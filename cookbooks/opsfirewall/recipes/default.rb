#
# Cookbook:: opsfirewall
# Recipe:: default
#

include_recipe 'firewall::default'

firewall 'default'

# open standard ssh port
firewall_rule 'ssh' do
  port     22
  command  :allow
end

firewall_rule 'http/https' do
  protocol :tcp
  port     [80, 8080, 443]
  command   :allow
end

