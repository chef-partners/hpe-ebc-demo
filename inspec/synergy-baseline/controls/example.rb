# encoding: utf-8
# copyright: 2018, The Authors

rom_version_attr = attribute('rom_version', default: 'I39 v1.30 08/26/2014', description: 'Version of the server hardware firmware to test for')
mp_firmware_version_attr = attribute('mp_firwmare_version', default: '2.55(b)(26 Feb 2018)', description: 'Version of the firmware installed on the iLO')
power_state_attr = attribute('power_state', default: 'On', description: 'Power state of the machines to look for')
server_count = attribute('server_count', default: 14, description: 'Number of servers to check against')

title 'Synergy Servers'

control 'synergy-servers-1.0' do
  impact 1.0
  title 'Compliance profiles for Synergy'
  desc 'Example profiles for Servers running on Synergy'

  describe oneview_servers do
    its('category') { should cmp 'server-hardware' }
    its('total') { should > server_count }
  end

  # Check the power state of all the servers
  describe oneview_servers.where { power_state != power_state_attr } do
    its('name') { should eq [] }
    its('power_state') { should eq [] }
  end

  describe oneview_servers.where { rom_version != rom_version_attr } do
    its('entries.length') { should cmp 0 }
    its('rom_version') { should eq [] }
    its('rom_version_type') { should cmp 'I39' }
    its('name') { should eq [] }
  end

  describe oneview_servers.where { rom_version_type_version < Gem::Version.new('40') } do
    its('name') { should eq [] }
  end

  describe oneview_servers.where { mp_firmware_version != mp_firmware_version_attr } do
    its('name') { should eq [] }
  end

  target_date = Date.parse('2017-10-25')
  describe oneview_servers.where { rom_version_date < target_date } do
    its('rom_version_date') { should eq [] }
    its('name') { should eq [] }
  end

  describe oneview_servers.where { status == 'Critical' } do
    it { should_not exist }
  end
end
