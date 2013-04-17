default[:glusterfs][:server][:prefix]  = '/srv/glusterfs-bricks'
default[:glusterfs][:server][:volumes] = ['shared']
default[:glusterfs][:server][:replica] = 2
default[:glusterfs][:peers] = ['host1', 'host2']
