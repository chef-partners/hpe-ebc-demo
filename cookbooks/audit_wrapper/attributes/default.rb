# This is a Chef attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

# Set a default name
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'

case node['os']
when 'linux'
default['audit']['profiles'] = [
  {
    'name': 'CIS CentOS Linux 7 Benchmark Level 2 - Server',
    'compliance': 'admin/cis-centos7-level2-server'
  }
]
when 'windows'
default['audit']['profiles'] = [
  {
   'name': 'DevSec Windows Security Baseline',
   'compliance': 'admin/windows-baseline' 
  }
]
end

case node['name']
when 'Syn1'
default['audit']['profiles'] = [
  {
    'name': 'Synergy Baseline Profile',
    'compliance': 'admin/synergy-baseline'
  }
]
end
# For further information, see the Chef documentation (https://docs.chef.io/essentials_cookbook_attribute_files.html).
