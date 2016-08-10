HI!

This time I want to tell you how to manage services and processes using sparrowdo.

Before this post a following list of topics was written by me:

* [Sparrowdo automation. Part 4. Managing users and groups.](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-4-managing-users-and-groups.html)

* [Sparrowdo automation. Part 3. Installing system packages.](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-3-installing-system-packages.html)

* [Sparrowdo automation. Part 2. Dealing with http proxy servers](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-2-dealing-with-http-proxy-servers.html)

* [Sparrowdo automation. Part 1. Installing cpan packages](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation---installing-cpan-packages.html)


As services are highly coupled with processes we will investigate them in one post.

Let's have an [nginx](https://nginx.org) web server gets installed on your system:

    $ cat sparrowfile
  
    use v6;

    use Sparrowdo;

    task_run  %(
      task => 'install nginx server',
      plugin => 'package-generic',
      parameters => %( list => 'nginx' )
    );
    

We talked about `package-generic` plugin at [this post](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-3-installing-system-packages.html).
We use this plugin to install system packages.

![install nginx server](https://raw.githubusercontent.com/melezhik/papers/master/nginx-install.png)


Ok. This is very logical now having installed an nginx to make it "bootable", so next reboot of our system
will pickup an nginx and make it sure it runs too. Some people call this autoload:



    $ cat sparrowfile
  
    use v6;

    use Sparrowdo;

    task_run %(
      task => 'enable nginx service',
      plugin => 'service',
      parameters => %( action => 'enable', service => 'nginx' )
    );
    
    task_run %(
      task => 'start nginx service',
      plugin => 'service',
      parameters => %( action => 'start', service => 'nginx' )
    );
    
![nginx-up-and-running](https://raw.githubusercontent.com/melezhik/papers/master/nginx-up-and-running.png)

A [service](https://sparrowhub.org/info/service) plugin makes it possible to enable and disabling Linux services, as well as starting and stopping them.
It's very simple yet useful plugin for those who wants to automate Linux services on target hosts. 

At example here we not only make it nginx autoloadable enabling it, but also make it sure it starts. So good so far.





