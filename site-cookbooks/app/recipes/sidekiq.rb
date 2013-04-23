directory '/srv/scratch' do
  recursive true
end

mount '/srv/scratch' do
  fstype 'tmpfs'
  device 'tmpfs'
  options 'size=2G'
  action [:mount, :enable]
end

template '/etc/init/sidekiq-market.conf' do
  source 'sidekiq-market.erb'
  owner 'root'
  mode '0644'
  variables :app_path => node[:app][:sidekiq][:app_path],
            :rvm_env  => node[:app][:sidekiq][:rvm_env],
            :threads  => node[:app][:sidekiq][:market_threads],
            :host     => node[:hostname]
end

service "sidekiq-market" do
  provider Chef::Provider::Service::Upstart
  action [:enable] # manual start with capistrano
end

template '/etc/init/sidekiq-bg.conf' do
  source 'sidekiq-bg.erb'
  owner 'root'
  mode '0644'
  variables :app_path => node[:app][:sidekiq][:app_path],
            :rvm_env  => node[:app][:sidekiq][:rvm_env],
            :threads  => node[:app][:sidekiq][:bg_threads],
            :host     => node[:hostname]
end

service "sidekiq-bg" do
  provider Chef::Provider::Service::Upstart
  action [:enable] # manual start with capistrano
end
