include_recipe 'hostname'

execute "remove bogus ovh local dns setup (localhost)" do
  command "sed -i 's/nameserver 127.0.0.1//' /etc/resolv.conf"
end

node['hosts'].each do |host, ip|
  hostsfile_entry ip do
    hostname host
    action :create
  end
end
