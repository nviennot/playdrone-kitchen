default[:ssd][:old_mount_point] = '/home'
default[:ssd][:md_device]       = '/dev/md2'
default[:ssd][:fstype]          = 'ext4'
default[:ssd][:devices]         = ["/dev/sda2", "/dev/sdb2"]
default[:ssd][:mount_point]     = '/srv'
default[:ssd][:mount_options]   = ['defaults', 'noatime']
default[:ssd][:raid_level]      = '1'
