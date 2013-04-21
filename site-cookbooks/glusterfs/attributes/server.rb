default[:glusterfs][:server][:prefix]  = '/srv/glusterfs-bricks'
default[:glusterfs][:server][:volumes] = ['repos']
default[:glusterfs][:server][:replica] = 2
default[:glusterfs][:peers] = ['host1', 'host2']
