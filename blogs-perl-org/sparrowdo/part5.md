HI!

This time I want to tell you how to manage services and proccess using sparrowdo.

Before this post a following list of topics was written by me:

* [Sparrowdo automation. Part 4. Managing users and groups.](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-4-managing-users-and-groups.html)

* [Sparrowdo automation. Part 3. Installing system packages.](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-3-installing-system-packages.html)

* [Sparrowdo automation. Part 2. Dealing with http proxy servers](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-2-dealing-with-http-proxy-servers.html)

* [Sparrowdo automation. Part 1. Installing cpan packages](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation---installing-cpan-packages.html)


As services are highly coupled with processes we will investigate them in one post.

Let's have a nginx web server get installed on your system:

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

![install nginx server]()
