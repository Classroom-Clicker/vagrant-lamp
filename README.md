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
- [Vagrant](http://www.vagrantup.com/downloads.html)
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Git](http://git-scm.com/downloads)
- [Ruby](https://www.ruby-lang.org/fr/)

Installation
------------
1) Checkout this repository ```git clone git@github.com:Classroom-Clicker/vagrant-lamp```

2) Install the ruby gem call berkshelf ``` gem install berkshelf ``` (might require sudo depending on your ruby installation)

3) Install the vagrant plugins berkshelf, hostmanager and omnibus
```
vagrant plugin install vagrant-berkshelf
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-omnibus
```

4) Run the command ```vagrant up --provision``` in the just created directory. It will create the vm.

5) You are done. You web server is up, you can start modifying the content of the public directory

How to use
----------
Here are the basic commands of vagrant :

- ```vagrant up``` : start or restart a vagrant vm
- ```vagrant provision``` : provisions the vm. It will execute the commands in the vagrant file.
- ```vagrant suspend``` : suspend the vagrant vm in virtualbox
- ```vagrant halt``` : halt the vagrnat vm in virtualbox
- ```vagrant destroy``` : delete a vagrant vm from virtualbox
- ```vagrant ssh``` : open a ssh shell to the vagrant vm

It is better to suspend or halt the vm after every use because restarting your computer with a live vagrant vm can create errors.

Every time the vm is provisionned, the database will be destroyed and recreated.

See the website
-------------
To acess the newly created website open a browser and access to 33.33.33.100 or clicker.dev
