Vagrant LAMP
============

This repo is the LAMP stack used for the dev of the classroom-clicker.

Contains
--------
- Apache 2
- Mysql
- Php 5.4
- Xdebug

Version
-------
0.1

Requirements
------------
- [Vagrant](http://www.vagrantup.com/downloads.html).
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads).
- [Git](http://git-scm.com/downloads).

Installation
------------
1. Checkout the repository ```git clone git@github.com/Classroom-Clicker/vagrant-lamp```
2. Run the command ```vagrant up --provision``` in the just created directory
3. Nothing. You web server is up, you can start modifying the content of the public directory

How to use
----------
Here are the basic commands of vagrant :

- ```vagrant up --provision``` : start or restart a vagrant vm
- ```vagrant suspend``` : suspend the vagrant vm in virtualbox
- ```vagrant halt``` : halt the vagrnat vm in virtualbox
- ```vagrant destroy``` : delete a vagrant vm from virtualbox
- ```vagrant ssh``` : open a ssh shell to the vagrant vm

It is better to suspend or halt the vm after every use because restarting your computer with a live vagrant vm can create errors.

See the website
-------------
To acess the newly created website open a browser and access to 33.33.33.100 or clicker.dev
