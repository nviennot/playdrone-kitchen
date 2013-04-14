default[:ssd][:old_mount_point] = '/home'
default[:ssd][:md_device]       = '/dev/md3'
default[:ssd][:fstype]          = 'ext4'
default[:ssd][:devices]         = ["/dev/sda3", "/dev/sdb3"]
default[:ssd][:mount_point]     = '/srv'
default[:ssd][:mount_options]   = ['defaults', 'noatime']
