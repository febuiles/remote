Remote
======

**This is a work in progress.**

Remote is a tool for setting up VPS. It installs a couple of bash scripts and some useful tools like
RVM.

Usage
-----

     remote add [name] [user@host]
     remote setup [name]

`name` is the name you want to give to this server. It will be added to your `~/.ssh/config` file
under that name. `user` and `host` are the login credentials. Remote assumes you're using SSH keys
instead of passwords.

Extras
------------

By default Remote only copies some bash files to the server to make your life easier. If you want to
add more features check the following commands:

### Apache + Passenger

We use Apache + Passenger to run our applications. To install Apache and Passenger in your server
run:

    remote setup:apache
    remote setup:passenger

### CI setup

We usually keep several instances of CIJoe in the same server for all the projects we handle. We followed the
instructions in [http://chrismdp.github.com/2010/03/multiple-ci-joes-with-rack-and-passenger/] to
set it up with Apache Passenger (so this is what this feature uses).

1. To install CIJoe run:

     remote setup:cijoe [name]

Where `name` is the name of the host you used when you setup the server. You will be prompted for
the URL used to access the CI server.

2. To add a new CIJoe instance to your server:

     remote cijoe:add [your_github_repo]

Replace `[your_github_repo]` with the URL of your Github repository. This works for public and
private repositories. Example:

     remote cijoe:add git@github.com:stackbuilders/remote.git

Adding a CIJoe instance will:

* Add a VHost for Apache.
* Create the directory to hold the application.
* Update from the repository and start running CIJoe.

After this you can access the repository at the URL you specified in step 1.


