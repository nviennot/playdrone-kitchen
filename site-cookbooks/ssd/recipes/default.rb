mount "/home" do
  device "/dev/md2"
  fstype "ext4"
  action [:umount, :disable]
end

mdadm "/dev/md2" do
  devices ["/dev/sda2", "/dev/sdb2"]
  level 1
  action :stop
  only_if "cat /proc/mdstat | grep md2 | grep raid1"
end

mdadm "/dev/md2" do
  devices ["/dev/sda2", "/dev/sdb2"]
  level 0
  chunk 64
  action [:create, :assemble]
end

bash "create_filesystem" do
  code <<-SCRIPT
    mkfs.ext4 /dev/md2
  SCRIPT
  not_if "blkid /dev/md2 | grep ext4"
end

directory "/srv" do
  mode "0755"
end

mount "/srv" do
  device "/dev/md2"
  fstype "ext4"
  options ['defaults', 'noatime']
  action [:mount, :enable]
end
