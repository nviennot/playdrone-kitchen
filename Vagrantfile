# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'
require 'berkshelf/vagrant'

Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true
  config.vm.box = "ubuntu-12.04-server-amd64"

  config.vm.define :node1 do |box|
    box.vm.provider(:virtualbox) do |vb|
      vb.name = box.vm.hostname = 'node1'
      vb.customize ["modifyvm", :id, "--memory", 2048]
    end
    box.vm.network :private_network, ip: "10.1.1.11"
    box.vm.network :forwarded_port, guest: 8080, host: 8080 # Elastic search
    box.vm.network :forwarded_port, guest: 8000, host: 8000 # Graphite
    box.vm.network :forwarded_port, guest: 80,   host: 4000 # Application

    box.vm.provision :chef_solo do |chef|
      chef.roles_path = "roles"
      chef.run_list = [
        "recipe[hosts]",
        "recipe[base]",
        "recipe[time]",
        "role[graphite]",
        "role[collectd_graphite]",
        "role[elasticsearch]",
        "recipe[glusterfs::server]",
        "recipe[glusterfs::client]",
        "role[redis]",
        "recipe[ruby]",
        "recipe[app::unicorn]",
        "recipe[app::sidekiq]",
      ]

      chef.json = {
        hosts: {
          'monitor' => '10.1.1.11',
          'node1'   => '10.1.1.11',
          'node2'   => '10.1.1.12'
        },

        apache:   { listen_ports: [8000] },
        graphite: { listen_port: 8000, storage_schemas: [{ name: 'catchall', pattern: '^.*', retentions: '1s:1d' }] },
        elasticsearch: {
          bootstrap: { mlockall: false },
          network: { publish_host: '10.1.1.11' },
          'discovery.zen.ping.unicast.hosts' => ["node1", "node2"]
        },
        glusterfs: { peers: ['node1', 'node2'] },
      }
    end
  end

  config.vm.define :node2 do |box|
    box.vm.provider(:virtualbox) do |vb|
      vb.name = box.vm.hostname = 'node2'
      vb.customize ["modifyvm", :id, "--memory", 2048]
    end
    box.vm.network :private_network, ip: "10.1.1.12"
    box.vm.network :forwarded_port, guest: 8080, host: 8081 # Elastic search

    box.vm.provision :chef_solo do |chef|
      chef.roles_path = "roles"
      chef.run_list = [
        "recipe[hosts]",
        "recipe[base]",
        "recipe[time]",
        "role[collectd_graphite]",
        "role[elasticsearch]",
        "recipe[glusterfs::server]",
        "recipe[glusterfs::client]",
        "recipe[ruby]",
        "recipe[app::sidekiq]",
        "recipe[app::metrics]",
      ]

      chef.json = {
        hosts: {
          'monitor' => '10.1.1.11',
          'node1'   => '10.1.1.11',
          'node2'   => '10.1.1.12'
        },

        elasticsearch: {
          bootstrap: { mlockall: false },
          network: { publish_host: '10.1.1.12' },
          'discovery.zen.ping.unicast.hosts' => ["node1", "node2"]
        },
        glusterfs: { peers: ['node1', 'node2'] },
      }
    end
  end
end
