# -*- mode: ruby -*-
# vi: set ft=ruby :

# General configuration
#######################
require './config/general.rb'
require './config/database.rb'

packages = %w{ php5-mysqlnd php5-xdebug libapache2-mod-php5 php5-curl php-pear curl}


### Do not modify this unless you know what you are doing
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# All Vagrant configuration is done here.

	# Enable Berkshelf support
	config.berkshelf.enabled = true

	# Define the VM box to use.
	config.vm.box = "precise32"
	config.vm.box_url = "http://files.vagrantup.com/precise32.box"

	# make sure omnibus is up to date
	config.omnibus.chef_version = :latest

	# set virtualbox configuration
	config.vm.provider :virtualbox do |vb|
		vb.name = "Vagrant-"+ App::Project_name
	end
	config.vm.boot_timeout = 120


	# Manage the adress and hostname of the VM
	config.vm.network :private_network, ip: App::Ip_address
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true
	config.vm.define App::Project_name do |node|
		node.vm.hostname = App::Project_name + ".dev"
		node.vm.network :private_network, ip: App::Ip_address
		node.hostmanager.aliases = [ "www." + App::Project_name + ".dev" ]
	end
	config.vm.provision :hostmanager

	# set the shared folder
	config.vm.synced_folder "./public/" , App::Src_path, {:mount_options => ["dmode=777", "fmode=666"]}

	# update the apt repository
	config.vm.provision :shell, :inline => "apt-get update -qq"

	# Enable and configure chef solo
	config.vm.provision :chef_solo do |chef|
		chef.custom_config_path = "Vagrantfile.chef"
		# add the recipes
		chef.add_recipe "vagrant-lamp::web_server"
		chef.add_recipe "vagrant-lamp::database"

		chef.json = {
			:app => {
				:name => App::Project_name,
				:src_path => App::Src_path,

				:server_name    => App::Project_name + ".dev",
				:server_aliases =>  [ "www." + App::Project_name + ".dev" ],
				:server_address => App::Ip_address,
				:packages => packages,
			},
			:php =>{
				:install_method => "package",
				:directives => {}
			},
			:mysql => {
				:host => 'localhost',
				:server_root_password 	=> Database::Root_password,
				:server_repl_password 	=> Database::Root_password,
				:server_debian_password	=> Database::Root_password,
				:bind_address 			=> App::Ip_address,
				:allow_remote_root 		=> true,

				:database_name => Database::Database_name,
				:database_user => Database::Database_user,
				:database_password => Database::Database_password,
				:database_dump => "/vagrant/config/"+Database::Database_dump
			}
		}
	end

end
