# Raku-utils project

Sparrow is Raku based automation tool comes with the idea of Sparrow plugins - small reusable pieces of code,
runs as command line utilities or Raku function.

Raku:

    my %state = task-run "say name", "name", %(
      bird => "Sparrow"
    );

    say %state<name>;


Cli:

    $ s6 --plg-run name@bird=Sparrow


One can even create _wrappers_ for existing command line tools converting them into Raku function:


    $ cat task.bash

    curl $(config args)

Raku function:

    task-run ".", %(
      args => [
        ['fail','location'],
        %(
          "output" => "data.html"
        );
        'raku'
      ]
    );

# Wrapper for Raku module command line scripts

Many Raku modules author nowadays ship their distribution with command line utilities to provide handy console
way functionality for their modules.

Imagine we create a Sparrow wrapper for those scripts converting them back to functions:


    task-run "mi6 release", "raku-utils-mi6", %(

      args => [

        ['verbose'],
        %(
          jobs => 2
        )
      ]

    );

All what is required from Sparrow prospective is minimal amount of work:


    $ task.bash

    mi6 $(config args)


    $ depends.raku

    App::Mi6

The last file is needed so that Sparrow could install Raku module dependency during plugin installation.

So eventually we might have a repository of `raku-utils` plugins comes as Sparrow plugins:

    $ s6 --search raku-utils

I might create a script that download all `zef` distribution, sorting out those that ship scripts and create Sparrow wrappers
for all of them. That would add a dozens of new plugins at no cost to existing Sparrow Eco system!

Not even that, now people writing automation tasks could use all those scripts in Raku functional way.


# Conclusion

I've introduced the idea of adding Sparrow plugins for exiting command Raku command line scripts shipped as part of Raku modules.
I am interested to hear your feedback.

Thanks

Alexey
