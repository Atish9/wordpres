
path = Chef::Config[:file_cache_path]

remote_file "/#{path}/latest.tar.gz" do
        source "http://wordpress.org/latest.tar.gz"
        action :create_if_missing
  end

bash "extract_wordpress" do
  cwd "/#{path}"
  code <<-EOH
  tar -xzvf latest.tar.gz -C /var/www/html/
  chown -R apache:apache /var/www/html/wordpress
  mkdir -p /var/www/html/wordpress/wp-content/uploads
  chown -R :apache /var/www/html/wordpress/wp-content/uploads
  EOH
end


