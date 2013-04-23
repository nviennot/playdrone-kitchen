include_recipe 'app::shared'

template '/etc/init/metrics.conf' do
  source 'metrics.erb'
  owner 'root'
  mode '0644'
  variables :app_path => node[:app][:app_path],
            :rvm_env  => node[:app][:rvm_env]
end

service "metrics" do
  provider Chef::Provider::Service::Upstart
  action [:enable] # manual start with capistrano
end
