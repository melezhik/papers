
Sparrowdo modules - getting a bigger things using light primitives.

This is what have been seen before:

* [Sparrowdo automation. Part 5. Managing services and processes.](http://blogs.perl.org/users/melezhik/2016/08/sparrowdo-automation-part-5-managing-services-and-processes.html)

* [Sparrowdo automation. Part 4. Managing users and groups.](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-4-managing-users-and-groups.html)

* [Sparrowdo automation. Part 3. Installing system packages.](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-3-installing-system-packages.html)

* [Sparrowdo automation. Part 2. Dealing with http proxy servers](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation-part-2-dealing-with-http-proxy-servers.html)

* [Sparrowdo automation. Part 1. Installing cpan packages](http://blogs.perl.org/users/melezhik/2016/07/sparrowdo-automation---installing-cpan-packages.html)


Well, while keep writing a sparrowdo tutorial the tool keep growing too. Let me introduce something new
and excited about sparrowdo automation - how one easily create more high level entities using so called
_sparrowdo modules_.

# Sparrowdo modules ... 

So far we have talked about some sparrowdo _primitives_. They are light, they are small and they
relate to a small specific tasks, under the hood they are just sparrow plugins with parameters -
sparrowdo tasks.


Well here is the list to recall a few:


- System packages - package generic plugin
- CPAN packages - package plugin
- Users and groups - are user and group plugin
- Linux Services are represented by service plugin
- And more and more and more ...

And so on, you can get all them here, on sparrowhub site - [https://sparrowhub.org/search](https://sparrowhub.org/search).
Most of sparrow plugins are just black boxes to solve a specific task. More or less plugins are primitives.

Take a look at chef resources or ansible modules - they are probably of the same nature.


Now let's me introduce a sparrowdo module - a container for sparrow plugins.

Consider a quite common task. Installing Nginx web server. Having looked at sparrow toolkit we have
all necessary bricks to "build" a running Nginx server:


- Package-generic plugin to install nginx package
- Service plugin to enable and run nginx service

Let's write code then:

    use v6;
    
    unit module Sparrowdo::Nginx;
    
    use Sparrowdo;
    
    our sub tasks (%args) {
    
      task_run  %(
        task => 'install nginx',
        plugin => 'package-generic',
        parameters => %( list => 'nginx' )
      );
    
      task_run  %(
        task => 'enable nginx',
        plugin => 'service',
        parameters => %( service => 'nginx', action => 'enable' )
      );
    
      task_run  %(
        task => 'start nginx',
        plugin => 'service',
        parameters => %( service => 'nginx', action => 'start' )
      );
    
    
    }
    


