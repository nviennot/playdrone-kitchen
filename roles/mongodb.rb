name "bootstrap"
run_list "recipe[mongodb::10gen_repo]", "recipe[mongodb]"

default[:mongodb][:dbpath] = "/srv/mongodb"

default_attributes "mongodb" => {
  "dbpath" => "/srv/mongodb"
}

# cluster identifier
# default[:mongodb][:client_roles] = []
# default[:mongodb][:cluster_name] = nil
# default[:mongodb][:replicaset_name] = nil
# default[:mongodb][:shard_name] = "default"

# default[:mongodb][:init_script_template] = "mongodb.init.erb"

# default[:mongodb][:defaults_dir] = "/etc/default"
# default[:mongodb][:root_group] = "root"
# default[:mongodb][:package_name] = "mongodb-10gen"
# default[:mongodb][:apt_repo] = "debian-sysvinit"
