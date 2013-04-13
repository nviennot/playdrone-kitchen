node['hosts'].each do |ip, host|
  hostsfile_entry ip do
    hostname host
    action :create
  end
end

