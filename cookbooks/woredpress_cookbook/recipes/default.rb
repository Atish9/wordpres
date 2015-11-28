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

#  mysql2_chef_gem 'default' do
#   action :install
# end

# package "mysql-community-server" do
#   action :install
# end

# service "mysqld" do
#   action [:start, :enable]
# end



path = Chef::Config[:file_cache_path]

remote_file "/#{path}/['wordpress']['version'].tar.gz" do
        source "http://wordpress.org/latest.tar.gz"
        action :create_if_missing
    end

        bash "extract_wordpress" do
  cwd "/#{path}"
  code <<-EOH
  mkdir -p /var/www/html/wordpress
  tar -xzvf ['wordpress']['version'].tar.gz -C /var/www/html/wordpress
  chown -R apache:apache /var/www/html/wordpress
  chmod -R 755 /var/www/html/wordpress
  mkdir -p /var/www/html/wordpress/wp-content/uploads
  chown -R :apache /var/www/html/wordpress/wp-content/uploads
  EOH

end


# remote_file "/#{path}/drupal-#{node.drupal2.remote_file_v}.tar.gz" do
#         source "http://ftp.drupal.org/files/projects/drupal-#{node.drupal2.remote_file_v}.tar.gz"
#         action :create_if_missing
# end

# bash "extract_drupal" do
#   cwd "/#{path}"
#   code <<-EOH
#   mkdir -p /var/www/html/
#   tar -xzvf drupal-#{node.drupal2.remote_file_v}.tar.gz --strip-components=1 -C /var/www/html/
#   chown -R apache:apache /var/www/html/
#   chcon -R -t httpd_sys_content_rw_t /var/www/html/sites/
#   EOH




# execute 'configure-wordpress' do
#   command "wp core config --path=#{ node['wordpress']['base_dir'] } --dbname=#{ node['wordpress']['db']['name'] } --dbuser=#{ node['wordpress']['db']['user'] } --dbpass=#{ node['wordpress']['db']['pass'] }"
#   not_if "ls #{ node['wordpress']['base_dir'] }/wp-config.php"
# end




# mysql_service 'default' do
#   port '3306'
#   version '5.5'
#   initial_root_password 'redhat'
#   action [:create, :start]
# end



# bash "mysql_installation" do
#   code <<-EOH
#   mysql -e "update mysql.user set Password = Password('redhat') where User = 'root'"
#   mysql -e "drop user ''@'localhost'"
#   mysql -e "drop database wordpres"
#   mysql -e "flush privileges"
#   EOH
# end


# # bash "mysql -u root" do
# # code <<-EOH
# mysql -u root <<-EOF
# UPDATE mysql.user SET Password=PASSWORD('redhat') WHERE User='root';
# DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# DELETE FROM mysql.user WHERE User='';
# DELETE FROM mysql.db WHERE Db='wordpres' OR Db='wordpres\_%';
# FLUSH PRIVILEGES;
# EOF
# EOH
# end




# bash "mysql_installation" do
#   code <<-EOH
#   mysql_secure_installation <<-EOF
#   /n
#   y/n
#   connected/n
#   connected/n
#   y/n
#   y/n
#   y/n
#   y/n
#   EOF
#   EOH
# end





# mysql_database node['wordpress']['db']['name'] do
#   connection(
#     :host     => '127.0.0.1',
#     :username => node['wordpress']['db']['user'],
#     :password => node['wordpress']['db']['pass']
   
#     )
#   action :create
# end


# mysql_database_user node['wordpressdb']['db']['user'] do
#   password node['wordpress']['db']['pass']
#   database_name node['wordpress']['db']['name']
#   host '%'
#   privileges [:all]
#   require_ssl true
#   action :grant
# end


