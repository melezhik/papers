# Sparrowdo automation. Part 4. Managing users and groups.

Hi! This is a previous articles:

* [Sparrowdo automation. Part 3. Installing system packages.](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-3-installing-system-packages.html)

* [Sparrowdo automation. Part 2. Dealing with http proxy servers](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-2-dealing-with-http-proxy-servers.html)

* [Sparrowdo automation. Part 1. Installing cpan packages](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation---installing-cpan-packages.html)

This one is going to be quite short. We will learn how to manage linux users and groups using sparrowdo.


Let's get back to our ubiquitous example of installing CPAN modules:


    task_run  %(
      task => 'install 2 modules',
      plugin => 'cpan-package',
      parameters => %( 
        list => 'CGI DBI'
      ),
    );   

If we run this one we will see that CGI and DBI CPAN modules get installed into system paths, which is ok.

Consider a following case though:

  * create a user account

  * install some CPAN modules _locally_ for this user


Basically this means that once a user gets logged into his account he should be able to _use_ his modules:


    $ ssh -l some-user $some-host
    $ export PERL5LIB=~/lib/perl5/
    $ perl -MDBI -e 1
    $ perl -MCGI -e 1

Let's rewrite our latest code adding user account here:

    task_run  %(
      task => 'create user',
      plugin => 'user',
      parameters => %( name => 'foo' )
    );
        

    task_run  %(
      task => 'install 2 modules',
      plugin => 'cpan-package',
      parameters => %( 
        list => 'CGI DBI',
        user => 'foo',
        install-base => '~/'
      ),
    );   

And have it run:

    $ sparrowdo --ssh_user=vagrant  --ssh_port=2222 --host=127.0.0.1  
    running sparrow tasks on 127.0.0.1 ... 
    running task <create user> plg <user> 
    parameters: {name => foo}
    /tmp/.outthentic/1563/opt/sparrow/plugins/public/user/story.t .. 
    # [/opt/sparrow/plugins/public/user/modules/create]
    # uid=1002(foo) gid=1002(foo) groups=1002(foo)
    # user created
    ok 1 - output match 'user created'
    # [/opt/sparrow/plugins/public/user]
    # done
    ok 2 - output match 'done'
    1..2
    ok
    All tests successful.
    Files=1, Tests=2,  1 wallclock secs ( 0.02 usr  0.01 sys +  0.09 cusr  0.09 csys =  0.21 CPU)
    Result: PASS
    running task <install 2 modules> plg <cpan-package> 
    parameters: {install-base => ~/, list => CGI DBI, user => foo}
    /tmp/.outthentic/1659/opt/sparrow/plugins/public/cpan-package/story.t .. 
    # [/opt/sparrow/plugins/public/cpan-package/modules/cpanm]
    # install CGI into ~/ user foo ...
    # Successfully installed Test-Deep-1.120
    # Successfully installed Sub-Uplevel-0.25
    # Successfully installed Test-Warn-0.30
    # Successfully installed CGI-4.32
    # 4 distributions installed
    # install ok
    ok 1 - output match 'install ok'
    # [/opt/sparrow/plugins/public/cpan-package/modules/cpanm]
    # install DBI into ~/ user foo ...
    # Successfully installed DBI-1.636
    # 1 distribution installed
    # install ok
    ok 2 - output match 'install ok'
    # [/opt/sparrow/plugins/public/cpan-package]
    # cpan-package-done
    ok 3 - output match 'cpan-package-done'
    1..3
    ok
    All tests successful.
    Files=1, Tests=3, 68 wallclock secs ( 0.02 usr  0.01 sys + 46.61 cusr  9.56 csys = 56.20 CPU)
    Result: PASS
    

Let's check our freshly installed CPAN modules:


    $ vagrant ssh
    Last login: Mon Jul 25 08:58:21 2016 from 10.0.2.2
    Welcome to your Vagrant-built virtual machine.
    [vagrant@epplkraw0312t1 ~]$ sudo bash 
    [root@epplkraw0312t1 vagrant]# su - foo
    Last login: Пн июл 25 09:02:55 UTC 2016 on pts/1
    [foo@epplkraw0312t1 ~]$ PERL5LIB=~/lib/perl5/ perl -MCGI -e 1
    [foo@epplkraw0312t1 ~]$ PERL5LIB=~/lib/perl5/ perl -MDBI -e 1
    

Ok. We successfully installed desired stuff into the user's account.



And last thing in this tutorial. Managing linux groups. The code is going to be very simple, as with creating
users:


    task_run  %(
      task => 'create group',
      plugin => 'group',
      parameters => %( name => 'application',
      ),
    );   


Goodbye and see you soon at our next tutorial. Have not yet decided what it's going to be ;)




