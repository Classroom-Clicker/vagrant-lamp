#
# Cookbook Name:: app
# Recipe:: database
#
# Copyright 2013, Rémi GATTAZ
#
include_recipe 'mysql'
include_recipe 'mysql::server'
include_recipe 'database::mysql'

mysql_connection_info = {
	:host		=>	node['mysql']['host'],
	:username	=>	'root',
	:password	=>	node['mysql']['server_root_password']
}

mysql_database node['mysql']['database_name'] do
	connection	mysql_connection_info
	action		:create
end

mysql_database_user node['mysql']['database_user'] do
	connection		mysql_connection_info
	password		node['mysql']['database_password']
	database_name	node['mysql']['database_name']
	host			node['mysql']['host']
	privileges		[:all]
	action			[:create, :grant]
end

if File.file?("#{node['mysql']['database_dump']}")
	ruby_block "seed #{node['mysql']['name']} database" do
	block do
		%x[mysql -u #{node['mysql']['database_user']} -p#{node['mysql']['database_password']} #{node['mysql']['database_name']} < #{node['mysql']['database_dump']}]
	end
	action :create
	end
end
