include_recipe "apt"
include_recipe "git"
include_recipe "build-essential"
include_recipe "user"

keys = ['ssh-dss AAAAB3NzaC1kc3MAAACBAK5SBB6QW4lr6MCbn/YCFeH77VD4Qbbd8v94dwMIqS4P6iZ6tVGYS5hexzCZIrUf8Yiov82xnfqK5s6yzHjgm3zFTKl486FWVp8Qk1FxqcjZ2IjvSJWZQ+y6kEBqpQ6BZuEdd08CsJ2uAvTPyyGIkgT8lD0lQb15HGyOhuYNAsf5AAAAFQDlTKPx/qpvs7WwJJtf59j38nJXdwAAAIEAnAWD5CLwX/yqfv6V4Mq4V7wjt1j0uTLt/8YsogHZvrbHzoVdBvawwPkPm7wVUNY1Ixpi3ZrxFcU0u/iogaGTPVqHFTUXcLmpkbhTEA7NA+cN2+5QELp38zfZ84+TuLs+0ng4cgn79wmzvV/2TWA79Mc+R03VplYZWqeaWCFqWsoAAACAFmUE1+7qu4dlaMgxW8/MHtSn+tTmuiKoFWnm5kxDStUFZ2Lk1qPbpl6/zfU51sQBo1dvEweVo3N6Qss6Jx8p+niXr9P5PSKAezIHhv5cZPUtlDS60PzO2X+9YOXLmrknRbZ5w9lb0/qxRfe/hGedkBGF1OBz7dZbfN8eS8mor3Y= pafy@home']

user_account 'deploy' do
  ssh_keys keys
end

directory "/root/.ssh" do
  recursive true
end

file "/root/.ssh/authorized_keys" do
  content keys.join("\n")
  mode 0644
end

# Not using the sudo cookbook, it wants to use the sudoers.d directory
execute "add deploy to sudoers" do
  command "chmod +w /etc/sudoers && echo 'deploy ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && chmod -w /etc/sudoers"
  not_if "grep '^deploy ' /etc/sudoers"
end

# TODO Install the configuration files + ruby setup for the deploy user

['tmux', 'zsh', 'vim'].each do |pkg|
  package pkg == 'vim' ? 'vim-nox' : pkg

  git "#{Dir.home}/.#{pkg}" do
    repository "git://github.com/nviennot/#{pkg}-config.git"
    revision 'wip-sid' if pkg == 'vim'

    action :sync
    notifies :run, "bash[install_#{pkg}]", :immediately
  end

  bash "install_#{pkg}" do
    action :nothing
    cwd "#{Dir.home}/.#{pkg}"
    code "make install"
  end
end

['curl', 'sysstat', 'htop', 'iftop'].each do |pkg|
  package pkg
end
