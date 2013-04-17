default[:glusterfs][:client][:prefix]  = "/srv"
default[:glusterfs][:client][:volumes] = ['shared']

default[:glusterfs][:username] = 'gluserfs-user'
default[:glusterfs][:password] = 'gluserfs-password'
default[:glusterfs][:peers] = ['host1', 'host2']
