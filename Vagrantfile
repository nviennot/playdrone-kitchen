# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'
require 'berkshelf/vagrant'

Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true
  config.vm.box = "ubuntu-12.04-server-amd64"

  config.vm.define :master do |box|
    box.vm.provider(:virtualbox) do |vb|
      vb.name = box.vm.hostname = 'master'
      vb.customize ["modifyvm", :id, "--memory", 1024]
    end
    box.vm.network :private_network, ip: "10.1.1.1"
    box.vm.network :forwarded_port, guest: 8080, host: 8080 # Elastic search
    box.vm.network :forwarded_port, guest: 8000, host: 8000 # Graphite

    box.vm.provision :chef_solo do |chef|
      json = JSON.parse(File.open('./nodes/master.json').read)
      json.merge!(elasticsearch: { network: { publish_host: 'master' }, bootstrap: { mlockall: false } })
      chef.roles_path = "roles"
      chef.run_list = json.delete('run_list')
      chef.json = json
    end
  end

  config.vm.define :secondary do |box|
    box.vm.provider(:virtualbox) do |vb|
      vb.name = box.vm.hostname = 'secondary'
      vb.customize ["modifyvm", :id, "--memory", 1024]
    end
    box.vm.network :private_network, ip: "10.1.1.2"

    box.vm.provision :chef_solo do |chef|
      json = JSON.parse(File.open('./nodes/master.json').read)
      json.merge!(elasticsearch: { network: { publish_host: 'secondary' }, bootstrap: { mlockall: false } })
      chef.roles_path = "roles"
      chef.run_list = json.delete('run_list')
      chef.json = json
    end
  end
end
