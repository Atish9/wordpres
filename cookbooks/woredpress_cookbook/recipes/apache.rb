
package "httpd" do
  action :install
end

service "httpd" do
  action [:start, :enable]
end

template "/etc/httpd/conf/wordpress.conf" do
  source "wordpress.conf.erb"
  mode "644"
  owner "root"
  group "root"
  action :create
  notifies :restart, "service[httpd]"
end
