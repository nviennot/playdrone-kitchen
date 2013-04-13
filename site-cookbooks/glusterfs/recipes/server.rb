apt_repository_glusterfs

package "glusterfs-server"

service "glusterfs-server" do
  action :nothing
end

directory node[:glusterfs][:server][:export_directory] do
  recursive true
end

# This configuration installs a replicated glusterfs server
template "/etc/glusterfs/glusterd.vol" do
  source "server.erb"
  mode   "0644"
  owner  "root"
  group  "root"
  notifies :restart, resources(:service => "glusterfs-server")
end

service "glusterfs-server" do
  action :restart
end
