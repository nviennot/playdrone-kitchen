template '/srv/nodes.yml' do
  source 'nodes.yml.erb'
  owner 'root'
  mode '0644'
  variables :nodes => node[:app][:nodes]
end
