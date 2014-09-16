package "cmake"
package "python-virtualenv"
package "python-dev"

directory "#{node[:app][:app_path]}/shared" do
  recursive true
end

directory "#{node[:app][:app_path]}/shared/p27env" do
  recursive true
  notifies :run, "bash[install_internet_archive]", :immediately
end

bash "install_internet_archive" do
  action :nothing
  cwd "#{node[:app][:app_path]}/shared"
  code "virtualenv -p /usr/bin/python2.7 p27env && p27env/bin/pip install internetarchive"
end

template "#{node[:app][:app_path]}/shared/nodes.yml" do
  source 'nodes.yml.erb'
  owner 'root'
  mode '0644'
  variables :nodes => node[:app][:nodes]
end
