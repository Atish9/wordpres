

# mysql2_chef_gem 'default' do
#   action :install
# end

# package "mysql-community-server" do
#   action :install
# end

# service "mysqld" do
#   action [:start, :enable]
# end



# bash "mysql_installation" do
#   code <<-EOH
#   mysql -e "update mysql.user set Password = Password('redhat') where User = 'root'"
#   mysql -e "drop user ''@'localhost'"
#   mysql -e "drop database test"
#   mysql -e "flush privileges"
#   EOH
# end


# mysql_database node.wordpress.mysql.dbname do
#    connection connection2(
#      :host     => '127.0.0.1',
#      :username => 'root',
#      :password => node.wordpress.mysql.rootpass
#    )
#    action :create
 
#  end

# connection2 = {
#    :host     => '127.0.0.1',
#    :username => 'root',
#    :password => node.wordpress.mysql.rootpass
#  }


# mysql_database_user "#{node.wordpress.mysql.dbname_username}" do
#   connection connection2
#   password "#{node.wordpress.mysql.dbname_userpass}"
#   host 'localhost'
#   action :create
# end

# mysql_database_user "#{node.wordpress.mysql.dbname_username}" do
#   connection connection2
#    password "#{node.wordpress.mysql.dbname_userpass}"
#    database_name "#{node.wordpress.mysql.dbname}"
#    host '%'
#    privileges [:all]
#    require_ssl true
#    action :grant
#  end


mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node.wordpress.mysql.rootpass
 }

mysql_database node.wordpress.mysql.dbname do
  connection  mysql_connection_info
  action      :create
end

mysql_database_user node.wordpress.mysql.dbname_username do
  connection      mysql_connection_info
  password        node.wordpress.mysql.dbname_userpass
  host            'localhost'
  database_name   node.wordpress.mysql.dbname
  action          :create
end

mysql_database_user node.wordpress.mysql.dbname_username do
  connection      mysql_connection_info
  database_name   node.wordpress.mysql.dbname
  privileges      [:all]
  action          :grant
end 