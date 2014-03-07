#
# Cookbook Name:: app
# Recipe:: web_server
#
# Copyright 2013, Rémi GATTAZ
#

# Install Apache
include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"

# Install php
include_recipe "dotdeb"
include_recipe "dotdeb::php54"

# Install PHP5 packages
node['php']['packages'].each do |a_package|
  package a_package
end

# create apache config
template "#{node['apache']['dir']}/sites-available/#{node['app']['name']}.conf" do
	source 'web_app.conf.erb'
	notifies :restart, 'service[apache2]'
end

# enable website
apache_site "#{node['app']['name']}.conf" do
	enable true
end

#create xdebug config
template "/etc/php5/mods-available/xdebug.ini" do
	source "xdebug.ini.erb"
	owner "root"
	group "root"
	mode 0644
end

execute "phpunit" do
    command "pear config-set auto_discover 1 && pear install pear.phpunit.de/PHPUnit"
    action :run
end

#config.vm.provision :shell, :inline => ""
#config.vm.provision :shell, :inline =>
