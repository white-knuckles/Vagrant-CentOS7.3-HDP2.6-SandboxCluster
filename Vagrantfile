# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "parallels/centos-7.3"
    config.vm.box_check_update = false

    # workaround for known issue #2 https://seven.centos.org/2016/12/updated-centos-vagrant-images-available-v1611-01/
    config.vm.synced_folder ".", "/hdpdata"

    # config to prepare for HDP/Ambari installation
    config.vm.provision "base", type: "shell", path: "provision-base.sh"

    # configure parallels VM provider to share with all VM's
    config.vm.provider "parallels" do |prl|
      prl.linked_clone = true
      # prl.check_guest_tools = true
      # prl.update_guest_tools = true
      prl.customize [ "set", :id, "--on-window-close", "keep-running" ]
    end

    # Ambari1
    config.vm.define :ambari1 do |a1|
      a1.vm.hostname = "ambari1.local"
      a1.vm.network :private_network, ip: "192.168.0.11"
      a1.vm.provider :parallels do |vb|
        vb.memory = "2048"
      end
      a1.vm.network "forwarded_port", guest: 8080, host: 8080
      a1.vm.network "forwarded_port", guest: 80, host: 8081
    end

    # Master1
    config.vm.define :master1 do |m1|
      m1.vm.hostname = "master1.local"
      m1.vm.network :private_network, ip: "192.168.0.12"
      m1.vm.provider :parallels do |vb|
        vb.memory = "3072"
      end
    end

    # Slave1
    config.vm.define :slave1 do |s1|
      s1.vm.hostname = "slave1.local"
      s1.vm.network :private_network, ip: "192.168.0.21"
      s1.vm.provider :parallels do |vb|
        vb.memory = "2048"
      end
    end

    # Slave2
    config.vm.define :slave2 do |s2|
      s2.vm.hostname = "slave2.local"
      s2.vm.network :private_network, ip: "192.168.0.22"
      s2.vm.provider :parallels do |vb|
        vb.memory = "2048"
      end
    end    
end