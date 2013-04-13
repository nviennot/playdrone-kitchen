# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'
require 'berkshelf/vagrant'

Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true
  config.vm.box = "ubuntu-12.10-server-amd64"

  config.vm.define :master do |box|
    box.vm.provider(:virtualbox) { |vb| vb.name = box.vm.hostname = 'master' }
    box.vm.network :private_network, ip: "10.1.1.1"

    box.vm.provision :chef_solo do |chef|
      json = JSON.parse(File.open('./nodes/master.json').read)
      chef.roles_path = "roles"
      chef.run_list = json.delete('run_list')
      chef.json = json
    end
  end

  config.vm.define :secondary do |box|
    box.vm.provider(:virtualbox) { |vb| vb.name = box.vm.hostname = 'secondary' }
    box.vm.network :private_network, ip: "10.1.1.2"

    box.vm.provision :chef_solo do |chef|
      json = JSON.parse(File.open('./nodes/master.json').read)
      chef.roles_path = "roles"
      chef.run_list = json.delete('run_list')
      chef.json = json
    end
  end
end
