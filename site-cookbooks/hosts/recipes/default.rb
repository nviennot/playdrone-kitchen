include_recipe 'hostname'

node['hosts'].each do |host, ip|
  hostsfile_entry ip do
    hostname host
    action :append
  end
end
