mount node[:ssd][:old_mount_point] do
  device node[:ssd][:md_device]
  action [:umount, :disable]
end

mount node[:ssd][:mount_point] do
  device node[:ssd][:md_device]
  action [:umount, :disable]
end

mdadm node[:ssd][:md_device] do
  devices node[:ssd][:devices]
  action :stop
end

mdadm node[:ssd][:md_device] do
  devices node[:ssd][:devices]
  level node[:ssd][:raid_level].to_i
  chunk 64
  action [:create, :assemble]
end

bash "create_filesystem" do
  code <<-SCRIPT
    mkfs.#{node[:ssd][:fstype]} #{node[:ssd][:md_device]}
  SCRIPT
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
