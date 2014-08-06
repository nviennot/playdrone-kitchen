name "redis"

run_list "recipe[redis::server]"

default_attributes redis: {
  install_type: 'source',
  source: {
    sha:     "b87bc83d13b9bf1f20d41a0efd06eda78b80002e013566d8b69c332e0cbccb08",
    url:     "http://download.redis.io/releases",
    version: "2.8.13"
  },

  symlink_binaries: true,
  config: {
    bind: '0.0.0.0',
    dir: '/srv/redis',
    pidfile: '/srv/redis/redis.pid'
  }
}
