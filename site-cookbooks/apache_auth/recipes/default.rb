include_recipe 'htpasswd'

node[:apache_auth].each do |auth|
  htpasswd auth[:htpasswd_file] do
    user auth[:user]
    password auth[:password]
  end

  template auth[:htaccess_file] do
    source "htaccess.erb"
    owner "root"
    mode "0644"
    variables :htpasswd_file => auth[:htpasswd_file],
              :user          => auth[:user]
  end
end
