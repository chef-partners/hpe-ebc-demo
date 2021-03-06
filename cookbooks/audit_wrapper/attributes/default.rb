# This is a Chef attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

# Set a default name
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'

default['audit']['profiles'].push(
    'name': 'Check SSH version 2 is installed v0.1.0',
    'compliance': 'admin/ssh-check'
)

default['audit']['inspec_version']='latest'

# For further information, see the Chef documentation (https://docs.chef.io/essentials_cookbook_attribute_files.html).
