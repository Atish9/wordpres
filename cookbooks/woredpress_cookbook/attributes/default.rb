#default['wordpress']['version'] = '3.9.1'
# default['wordpress']['db']['name'] = 'wordpressdb'
# default['wordpress']['db']['user'] = 'root'
# default['wordpress']['db']['pass'] = 'redhat'

# # default['wordpress']['vhost_template'] = 'virtual.conf.erb'
# # default['wordpress']['server_name'] = 'wordpress.com'
# # default['wordpress']['server_aliases'] = ["www.#{ node['wordpress']['server_name'] }", ]





default.wordpress.mysql.dbconnection = 'connection2'
default.wordpress.mysql.rootpass = 'redhat'
default.wordpress.mysql.dbname = 'wordpressdbb'
default.wordpress.mysql.dbname_username = 'admin2'
default.wordpress.mysql.dbname_userpass = 'redhat'
