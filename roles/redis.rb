name "redis"

run_list "recipe[redis::server]"

default_attributes redis: {
  install_type: 'source',
  symlink_binaries: true,
  config: {
    dir: '/srv/redis'
  }
}
