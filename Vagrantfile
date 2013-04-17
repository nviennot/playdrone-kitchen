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
      chef.roles_path = "roles"
      chef.run_list = [
        "recipe[hosts]",
        "recipe[base]",
        "role[graphite]",
        "role[collectd_graphite]",
        "role[elasticsearch]",
        "recipe[glusterfs::server]",
        "recipe[glusterfs::client]",
        "role[mongodb]",
        "role[redis]",
        "recipe[ruby]",
      ]

      chef.json = {
        hosts: {
          'monitor'   => '10.1.1.1',
          'master'    => '10.1.1.1',
          'secondary' => '10.1.1.2'
        },

        apache:   { listen_ports: [8000] },
        graphite: { listen_port: 8000, storage_schemas: [{ name: 'catchall', pattern: '^.*', retentions: '1s:1d' }] },
        elasticsearch: {
          bootstrap: { mlockall: false },
          network: { publish_host: '10.1.1.1' },
          'discovery.zen.ping.unicast.hosts' => ["master", "secondary"]
        },
        glusterfs: { peers: ['master', 'secondary'] },
        mongodb: { hosts: ["master", "secondary"] }
      }
    end
  end

  config.vm.define :secondary do |box|
    box.vm.provider(:virtualbox) do |vb|
      vb.name = box.vm.hostname = 'secondary'
      vb.customize ["modifyvm", :id, "--memory", 1024]
    end
    box.vm.network :private_network, ip: "10.1.1.2"
    box.vm.network :forwarded_port, guest: 8080, host: 8081 # Elastic search

    box.vm.provision :chef_solo do |chef|
      chef.roles_path = "roles"
      chef.run_list = [
        "recipe[hosts]",
        "recipe[base]",
        "role[collectd_graphite]",
        "role[elasticsearch]",
        "recipe[glusterfs::server]",
        "recipe[glusterfs::client]",
        "role[mongodb]",
        "recipe[ruby]",
      ]

      chef.json = {
        hosts: {
          'monitor'   => '10.1.1.1',
          'master'    => '10.1.1.1',
          'secondary' => '10.1.1.2'
        },

        elasticsearch: {
          bootstrap: { mlockall: false },
          network: { publish_host: '10.1.1.2' },
          'discovery.zen.ping.unicast.hosts' => ["master", "secondary"]
        },
        glusterfs: { peers: ['master', 'secondary'] },
        mongodb: { hosts: ["master", "secondary"] }
      }
    end
  end
end
