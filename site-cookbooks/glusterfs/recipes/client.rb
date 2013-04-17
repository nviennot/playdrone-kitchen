apt_repository_glusterfs

package "glusterfs-client"

execute "add-fuse-to-modules" do
  command "echo fuse >> /etc/modules"
  user "root"
  not_if "grep fuse /etc/modules"
end

use_localhost = !([node[:hostname], node[:fqdn], node[:ipaddress]] & node[:glusterfs][:peers]).empty?

node[:glusterfs][:client][:volumes].each do |volume|
  mount_point = "#{node[:glusterfs][:client][:prefix]}/#{volume}"

  directory mount_point do
    recursive true
  end

  mount mount_point do
    if use_localhost
      device "localhost:#{volume}"
      only_if "gluster volume info #{volume}"
    else
      device "#{node[:glusterfs][:peers].first}:#{volume}"
    end

    fstype "glusterfs"
    action [:mount, :enable]
  end
end
