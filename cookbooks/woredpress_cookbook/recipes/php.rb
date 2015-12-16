
# package 'php-mysql' do
#   action :install
# end

# package 'php-pdo' do
#   action :install
# end

# package "php" do
#   action :install
# end


package ['php', 'php-pdo','php-mysql']  do
  action :install
end

template "/var/www/html/wordpress/wp-config.php" do
  source "wp-config.php.erb"
  mode "666"
  owner "apache"
  group "apache"
  action :create
end