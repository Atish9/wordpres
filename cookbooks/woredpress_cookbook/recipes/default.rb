#
# Cookbook Name:: woredpress_cookbook
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


#include_recipe 'ohai'
#include_recipe 'yum-epel'
include_recipe "selinux::disabled"

# httpd_service 'default' do
#   action [:create, :start]
# end


package "httpd" do
  action :install
end

service "httpd" do
  action [:start, :enable]
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

service "mysqld" do
  action [:start, :enable]
end


#mkdir -p /var/www/html/

path = Chef::Config[:file_cache_path]

remote_file "/#{path}/latest.tar.gz" do
        source "http://wordpress.org/latest.tar.gz"
        action :create_if_missing
    end

        bash "extract_wordpress" do
  cwd "/#{path}"
  code <<-EOH
  tar -xzvf latest.tar.gz -C /var/www/html/wordpress
  chown -R apache:apache /var/www/html/wordpress
  chmod -R 755 /var/www/html/wordpress
  mkdir -p /var/www/html/wordpress/wp-content/uploads
  chown -R :apache /var/www/html/wordpress/wp-content/uploads
  EOH

end

bash "mysql_installation" do
  code <<-EOH
  mysql -e "update mysql.user set Password = Password('redhat') where User = 'root'"
  mysql -e "drop user ''@'localhost'"
  mysql -e "drop database test"
  mysql -e "flush privileges"
  EOH
end

mysql_database node['wordpress']['db']['name'] do
  connection(
    :host     => '127.0.0.1',
    :username => 'root',
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

cookbook_file "/etc/httpd/conf/httpd.conf" do
  source "virtual.conf.erb"
  mode "644"
  owner "root"
  group "root"
  action :create
  notifies :restart, "service[httpd]"
end


template "/var/www/html/wordpress/wp-config.php.erb" do
  source "wp-config.php.erb"
  mode "666"
  owner "apache"
  group "apache"
  action :create
end