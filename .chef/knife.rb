# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "chef_server"
client_key               "#{current_dir}/chef_server.pem"
validation_client_name   "chef_works-validator"
validation_key           "#{current_dir}/chef_works-validator.pem"
chef_server_url          "https://api.chef.io/organizations/chef_works"
cookbook_path            ["#{current_dir}/../cookbooks"]
