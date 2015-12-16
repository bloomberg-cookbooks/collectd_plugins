#
# Cookbook: collectd_plugins
# License: Apache 2.0
#
# Copyright 2010, Atari, Inc
# Copyright 2015, Bloomberg Finance L.P.
#
include_recipe 'collectd::default'

module_name = node['collectd-plugins']['python']['module_name']
if module_name
    node['collectd-plugins']['python']['Import'] = module_name
    node['collectd-plugins']['python']['Module'] = { 'id' => module_name
                                                   , 'PluginName' => module_name }
end

collectd_plugin 'python' do
  user node['collectd']['service_user']
  group node['collectd']['service_group']
  directory node['collectd']['service']['config_directory']
  options node['collectd-plugins']['python']
  notifies :restart, "collectd_service[#{node['collectd']['service_name']}]", :delayed
end
