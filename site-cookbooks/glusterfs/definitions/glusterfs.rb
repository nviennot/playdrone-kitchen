define :apt_repository_glusterfs do
  apt_repository "glusterfs" do
    uri 'http://ppa.launchpad.net/semiosis/ubuntu-glusterfs-3.3/ubuntu'
    distribution node['lsb']['codename']
    components ['main']
    keyserver 'keyserver.ubuntu.com'
    key "774BAC4D"
  end
end
