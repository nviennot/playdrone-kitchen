include_recipe "apt"
include_recipe "git"
include_recipe "build-essential"

['tmux', 'zsh', 'vim'].each do |pkg|
  package pkg == 'vim' ? 'vim-nox' : pkg

  git "#{Dir.home}/.#{pkg}" do
    repository "git://github.com/nviennot/#{pkg}-config.git"
    action :sync
    notifies :run, "bash[install_#{pkg}]"
  end

  bash "install_#{pkg}" do
    action :nothing
    cwd "#{Dir.home}/.#{pkg}"
    code "make install"
  end
end

['sysstat', 'htop', 'iftop'].each do |pkg|
  package pkg
end
