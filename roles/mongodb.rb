name "mongodb"
run_list "recipe[mongodb::10gen_repo]", "recipe[mongodb::replicaset]"

default_attributes mongodb: {
  hosts: ["master", "secondary"], # no IPs, only hostnames
  dbpath: '/srv/mongodb',
  cluster_name: 'google-play-crawler',
  replicaset_name: 'google-play-crawler'
}
