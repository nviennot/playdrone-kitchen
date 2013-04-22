include_attribute 'elasticsearch::nginx'

default[:app][:unicorn][:port]     = 80
default[:app][:unicorn][:user]     = 'user'
default[:app][:unicorn][:password] = 'password'
default[:app][:unicorn][:app_path] = '/srv/google-play-crawler'
default[:app][:unicorn][:rvm_env]  = 'ruby-1.9.3-p327@google-play-crawler'
