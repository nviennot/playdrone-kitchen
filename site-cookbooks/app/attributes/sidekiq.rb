include_attribute 'app::shared'

default[:app][:sidekiq][:market_threads]  = 10
default[:app][:sidekiq][:bg_threads]  = 4
