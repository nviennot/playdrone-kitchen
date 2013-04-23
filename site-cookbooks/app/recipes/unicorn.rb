include_recipe 'elasticsearch::nginx'
include_recipe 'app::shared'

template "/etc/nginx/conf.d/unicorn.conf" do
  source "nginx-unicorn.erb"
  notifies :reload, 'service[nginx]'
  variables :app_path => node[:app][:app_path],
            :port     => node[:app][:unicorn][:port]
end

ruby_block "add users to unicorn passwords file" do
  block do
    require 'webrick/httpauth/htpasswd'
    @htpasswd = WEBrick::HTTPAuth::Htpasswd.new('/etc/nginx/unicorn-htpasswd')
    @htpasswd.set_passwd('Google Play With Me', node[:app][:unicorn][:user], node[:app][:unicorn][:password])
    @htpasswd.flush
  end
end

file '/etc/nginx/unicorn-htpasswd' do
  mode 0644
  action :touch
end

template '/etc/init/unicorn.conf' do
  source 'unicorn.erb'
  owner 'root'
  mode '0644'
  variables :app_path => node[:app][:app_path],
            :rvm_env  => node[:app][:rvm_env]
end

service "unicorn" do
  provider Chef::Provider::Service::Upstart
  action [:enable] # manual start with capistrano
end
