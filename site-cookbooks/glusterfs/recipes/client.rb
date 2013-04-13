apt_repository_glusterfs

package "glusterfs-client"

execute "add-fuse-to-modules" do
  command "echo fuse >> /etc/modules"
  user "root"
  not_if "grep fuse /etc/modules"
end

directory node[:glusterfs][:client][:mount_directory] do
  recursive true
end

template "/etc/glusterfs/glusterfs.vol" do
  source "client.erb"
  mode   "0644"
  owner  "root"
  group  "root"
end

mount node[:glusterfs][:client][:mount_directory] do
  device "/etc/glusterfs/glusterfs.vol"
  fstype "glusterfs"
  action [:mount, :enable]
end
