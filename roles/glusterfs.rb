name "glusterfs"
run_list "recipe[glusterfs::server]"

default_attributes glusterfs: {
  peers: ['master', 'secondary']
}
