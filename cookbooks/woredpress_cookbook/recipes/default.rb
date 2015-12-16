# #
# # Cookbook Name:: woredpress_cookbook
# # Recipe:: default
# #
# # Copyright 2015, YOUR_COMPANY_NAME
# #
# # All rights reserved - Do Not Redistribute
# #


include_recipe "selinux::disabled"
include_recipe "php"

include_recipe "woredpress_cookbook::apache"
include_recipe "woredpress_cookbook::php"
include_recipe "woredpress_cookbook::wordpress"
include_recipe "woredpress_cookbook::mysql"
