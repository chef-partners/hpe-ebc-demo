#
# Cookbook:: oneview_wrapper
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Data bags for oneview and automate specs
oneview = data_bag_item('demo', 'oneview_specs')
automate = data_bag_item('demo', 'automate_specs')

# Download oneview SDK
chef_gem 'oneview-sdk'

# Download and Install Oneview Plugin
git '/root/inspec-hpe-oneview' do
  repository 'https://github.com/inspec/inspec-hpe-oneview.git'
  revision 'master'
  action :sync
end

directory '/root/.inspec/plugins' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
end

link '/root/.inspec/plugins/inspec-hpe-oneview' do
  to '/root/inspec-hpe-oneview'
end

directory '/root/.oneview' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/root/.oneview/inspec' do
  source 'oneview_plugin_config.txt.erb'
  mode '0755'
  owner 'root'
  group 'root'
  action :create
  variables ({
    :oneview_url => oneview['url'],
    :oneview_pwd => oneview['password'],
    :oneview_user => oneview['user']
  })
end

# InSpec Profile for OneView
directory '/root/.oneview/synergy-baseline/controls' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
end

bash 'download_controls' do
  code <<-EOH
   curl https://raw.githubusercontent.com/chef-partners/hpe-ebc-demo/master/inspec/synergy-baseline/controls/example.rb -o /root/.oneview/synergy-baseline/controls/example.rb
   curl https://raw.githubusercontent.com/chef-partners/hpe-ebc-demo/master/inspec/synergy-baseline/inspec.yml -o /root/.oneview/synergy-baseline/inspec.yml
   EOH
end

template '/root/.oneview/reporter.json' do
  source 'automate_reporter.json.erb'
  mode '0755'
  owner 'root'
  group 'root'
  action :create
  variables ({
    :automate_url => automate['automate_url'],
    :token => automate['automate_token']
  })
end

execute 'run_inspec' do  
  cwd '/opt/chef/embedded/bin'  
  command './inspec exec /root/.oneview/synergy-baseline -t oneview:// --json-config /root/.oneview/reporter.json'
  returns [0,100,101,102]  
end

