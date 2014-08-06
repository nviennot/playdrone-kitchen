package "cmake"

directory "#{node[:app][:app_path]}/shared" do
  recursive true
end

template "#{node[:app][:app_path]}/shared/nodes.yml" do
  source 'nodes.yml.erb'
  owner 'root'
  mode '0644'
  variables :nodes => node[:app][:nodes]
end
