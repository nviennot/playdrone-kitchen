name "glusterfs"
run_list "recipe[glusterfs::server]", "recipe[glusterfs::client]"

override_attributes glusterfs: {
  client: { mount_directory:  "/srv/apks"      },
  server: { export_directory: "/srv/glusterfs" },
  username: 'gluserfs-user',
  password: 'gluserfs-password',
  hosts: ['master', 'secondary']
}
