mount node[:ssd][:old_mount_point] do
  device node[:ssd][:md_device]
  fstype "ext4"
  action [:umount, :disable]
end

mdadm node[:ssd][:md_device] do
  devices node[:ssd][:devices]
  level 1
  action :stop
  only_if "cat /proc/mdstat | grep #{node[:ssd][:md_device].split('/').last} | grep raid1"
end

mdadm node[:ssd][:md_device] do
  devices node[:ssd][:devices]
  level 0
  chunk 64
  action [:create, :assemble]
  notifies :run, "bash[create_filesystem]"
end

bash "create_filesystem" do
  code <<-SCRIPT
    mkfs.#{node[:ssd][:fstype]} #{node[:ssd][:md_device]}
  SCRIPT
  action :nothing
end

directory node[:ssd][:mount_point] do
  mode "0755"
end

mount node[:ssd][:mount_point] do
  device node[:ssd][:md_device]
  fstype node[:ssd][:fstype]
  options node[:ssd][:mount_options]
  action [:mount, :enable]
end
