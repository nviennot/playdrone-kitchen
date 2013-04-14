include_recipe "git"

include_recipe "rvm::system"

# For some reason -falcon gets appended to the ruby string when we apply the falcon patch.
# We don't want that.
execute "alias ruby" do
  command "/usr/local/rvm/bin/rvm alias create ruby-1.9.3-p327 ruby-1.9.3-p327-falcon"
  only_if "/usr/local/rvm/bin/rvm list | grep ' ruby-1.9.3-p327-falcon '"
  not_if  "/usr/local/rvm/bin/rvm alias list | grep '^ruby-1.9.3-p327 '"
end

git "#{Dir.home}/.irb" do
  repository "git://github.com/nviennot/irb-config.git"
  action :sync
  notifies :run, "bash[install_irb_config]", :immediately
end

bash "install_irb_config" do
  action :nothing
  cwd "#{Dir.home}/.irb"
  code "make install"
end
