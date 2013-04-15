name "glusterfs"
run_list "recipe[glusterfs::server]", "recipe[glusterfs::client]"

default_attributes glusterfs: {
  client: { mount_directory:  "/srv/apks"      },
  server: { export_directory: "/srv/glusterfs" },
  username: 'user',
  password: 'password',
  hosts: ['master', 'secondary']
}
