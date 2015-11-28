default['wordpress']['version'] = '3.9.1'
#default['wordpress']['base_dir'] = '/var/www/html/wordpress'
default['wordpress']['db']['name'] = 'wordpres'
default['wordpress']['db']['user'] = 'root'
default['wordpress']['db']['pass'] = 'redhat'


default['wordpress']['vhost_template'] = 'virtual.conf.erb'
default['wordpress']['server_name'] = 'wordpress.com'
default['wordpress']['server_aliases'] = ["www.#{ node['wordpress']['server_name'] }", ]


