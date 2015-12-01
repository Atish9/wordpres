name             'woredpress_cookbook'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures woredpress_cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


supports 'centos'

#depends 'ohai'
#depends 'yum-epel'
depends 'mysql'
depends 'database'
depends 'selinux'
depends 'mysql2_chef_gem'
depends 'php'
depends 'httpd'
depends 'openssl'