#
# Cookbook:: pwd_policy
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Set Enforce password history to 24 or more passwords
password_policy 'password_history' do
  policy_command 'uniquepw'
  value 24
  action :set
end
