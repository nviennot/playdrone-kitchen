include_recipe "git"

include_recipe "rvm::system"

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
