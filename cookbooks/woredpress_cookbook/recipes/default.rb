#
# Cookbook Name:: woredpress_cookbook
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'ohai'
include_recipe 'yum-epel'
include_recipe "selinux::disabled"

httpd_service 'default' do
  action [:create, :start]
end

package 'php-gd' do
  action :install
end

package 'php-mysql' do
  action :install
end

package 'php-pdo' do
  action :install
end

package 'php-xml' do
 action :install
end

package "php" do
  action :install
end

 mysql2_chef_gem 'default' do
  action :install
end

package "mysql-community-server" do
  action :install
end

mysql_client 'default' do
  action :create
end



path = Chef::Config[:file_cache_path]

remote_file "/#{path}/['wordpress']['version'].tar.gz" do
        source "http://wordpress.org/['wordpress']['version'].tar.gz"
        action :create_if_missing

        bash "extract_wordpress" do
  cwd "/#{path}"
  code <<-EOH
  mkdir -p /var/www/html/wordpress
  tar --strip-components=1 -xzvf ['wordpress']['version'].tar.gz -C /var/www/html/wordpress
  chown -R apache:apache /var/www/html/wordpress
  chmod -R 755 /var/www/html/wordpress
  mkdir -p /var/www/html/wordpress/wp-content/uploads
  chown -R :apache /var/www/html/wordpress/wp-content/uploads
  EOH

end


execute 'configure-wordpress' do
  command "wp core config --path=#{ node['wordpress']['base_dir'] } --dbname=#{ node['wordpress']['db']['name'] } --dbuser=#{ node['wordpress']['db']['user'] } --dbpass=#{ node['wordpress']['db']['pass'] }"
  not_if "ls #{ node['wordpress']['base_dir'] }/wp-config.php"
end

mysql_service 'default' do
  port '3306'
  version '5.5'
  initial_root_password 'redhat'
  action [:create, :start]
end

mysql_database node['wordpress']['db']['name'] do
  connection(
    :host     => '127.0.0.1',
    :username => node['wordpress']['db']['user'],
    :password => node['wordpress']['db']['pass']
   
    )
  action :create
end


mysql_database_user node['wordpress']['db']['user'] do
  password node['wordpress']['db']['pass']
  database_name node['wordpress']['db']['name']
  host '%'
  privileges [:all]
  require_ssl true
  action :grant
end


