package "git-daemon-sysvinit"

directory "/srv/repos" do
  recursive true
end

template '/etc/default/git-daemon' do
  source 'git-daemon.erb'
  owner 'root'
  mode '0644'
  variables :git_root => '/srv/repos'
end

service "git-daemon" do
  provider Chef::Provider::Service::Init
  action [:start]
end
