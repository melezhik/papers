# Raku-utils project

[Sparrow](https://github.com/melezhik/Sparrow6) is a Raku based automation tool comes with the idea of Sparrow [plugins](https://github.com/melezhik/sparrow-plugins) - small reusable pieces of code, runs as command line or Raku function.

Raku:

    my %state = task-run "say name", "name", %(
      bird => "Sparrow"
    );

    say %state<name>;


Cli:

    $ s6 --plg-run name@bird=Sparrow


One can even create _wrappers_ for existing command line tools converting them into Raku functions:

Wrapper code:

    $ cat task.bash

    curl $(config args)

Raku function:

    task-run ".", %(
      args => [
        ['fail','location'],
        %(
          "output" => "data.html"
        );
        'http://raku.org'
      ]
    );

# Wrappers for Raku modules command line scripts

Many Raku modules author nowadays ship their distribution with command line tools to provide handy console
functionality for theirs modules.

It's relatively easy repackages those tools into Sparrow plugins. For example for [App::Mi6](https://modules.raku.org/dist/App::Mi6:cpan:SKAJI) module `mi6` tool:

    task-run "mi6 release", "raku-utils-mi6", %(

      args => [

        ['verbose'],
        %(
          jobs => 2
        )
      ]

    );

Sparrow wrapper:

    $ task.bash

    mi6 $(config args)

    $ cat sparrow.json
    {
        "name" : "raku-utils-mi6",
        "description" : "mi6 cli",
        "version" : "0.0.1",
        "category" : "utils"
    }

    $ depends.raku

    App::Mi6

The last file is needed so that Sparrow could install Raku module dependency during plugin installation.

So eventually we might have a repository of `raku-utils` plugins for _every_ Raku module exposing command line interface:

    $ s6 --search raku-utils

One day, I might create a script that would download all `zef` distribution, sorting out those having `bin/` scripts and create Sparrow wrappers
for all of them. That would add a dozens of new plugins to existing Sparrow eco system at no cost. 

And this would make it availbale to run those scripts as pure Raku functions, using Sparrow plugins interface!

# Conclusion

I've introduced the idea of adding Sparrow plugins for exiting command Raku commad line tools shipped as a part of Raku modules.

I'd happy to get a feedback on that.

Thanks

Alexey
