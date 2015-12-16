
# package 'php-mysql' do
#   action :install
# end

# package 'php-pdo' do
#   action :install
# end

# package "php" do
#   action :install
# end


package ['php', 'php-pdo','php-mysql','php-fpm']  do
  action :install
end

# template "/var/www/html/wordpress/wp-config.php" do
#   source "wp-config.php.erb"
#   mode "666"
#   owner "apache"
#   group "apache"
#   variables({


#   action :create
# end


template "/var/www/html/wordpress/wp-config.php" do
  source 'wp-config.php.erb'
  mode "0755"
  owner "apache"
  group "apache" 
  variables(
    :database    => node.wordpress.mysql.dbname,
    :user        => node.wordpress.mysql.dbname_username,
    :password    => node.wordpress.mysql.dbname_userpass,
  )
  not_if do

    File.exists?("/var/www/html/wordpress/wp-config.php")
  end
end