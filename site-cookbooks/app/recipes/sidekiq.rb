include_recipe 'app::shared'

directory "/srv/repos" do
  recursive true
end

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
  variables :app_path => node[:app][:app_path],
            :rvm_env  => node[:app][:rvm_env],
            :threads  => node[:app][:sidekiq][:market_threads],
            :host     => node[:hostname]
end

service "sidekiq-market" do
  provider Chef::Provider::Service::Upstart
  action [:enable] # manual start with capistrano
end

node[:app][:sidekiq][:bg_processes].times do |i|
  template "/etc/init/sidekiq-bg#{i+1}.conf" do
    source 'sidekiq-bg.erb'
    owner 'root'
    mode '0644'
    variables :app_path => node[:app][:app_path],
              :rvm_env  => node[:app][:rvm_env],
              :threads  => node[:app][:sidekiq][:bg_threads],
              :host     => node[:hostname]
  end

  service "sidekiq-bg#{i+1}" do
    provider Chef::Provider::Service::Upstart
    action [:enable] # manual start with capistrano
  end
end
