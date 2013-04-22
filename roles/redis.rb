name "redis"

run_list "recipe[redis::server]"

default_attributes redis: {
  install_type: 'source',
  symlink_binaries: true,
  config: {
    bind: '0.0.0.0',
    dir: '/srv/redis',
    pidfile: '/srv/redis/redis.pid'
  }
}
