template '/etc/init/metrics.conf' do
  source 'metrics.erb'
  owner 'root'
  mode '0644'
  variables :app_path => node[:app][:unicorn][:app_path],
            :rvm_env  => node[:app][:unicorn][:rvm_env]
end

service "metrics" do
  provider Chef::Provider::Service::Upstart
  action [:enable] # manual start with capistrano
end
