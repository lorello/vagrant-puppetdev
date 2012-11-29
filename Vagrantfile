# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.define :puppetmaster do |c|
        c.vm.box = "precise32"
        c.vm.box_url = "http://files.vagrantup.com/precise32.box"
        c.vm.network :hostonly, "10.20.30.2"
        c.vm.host_name = "puppetmaster.vagrant.local"
        c.vm.customize ["modifyvm", :id, "--memory", 512]
        c.vm.provision :shell do |shell|
            shell.path = "puppetmaster-bootstrap.sh"
        end
    end

    config.vm.define :puppetdb do |c|
        c.vm.box = "puppetprecise"
        c.vm.box_url = "http://dl.dropbox.com/u/51938100/vagrant-boxes/puppetprecise.box"
        c.vm.network :hostonly, "10.20.30.3"
        c.vm.host_name = "puppetdb"
        c.vm.customize ["modifyvm", :id, "--memory", 512]
        c.vm.forward_port 8080, 48080
        c.vm.forward_port 8081, 48081
        c.vm.provision :shell do |shell|
            shell.path = "puppetclient-bootstrap.sh"
        end
    end

    config.vm.define :puppethardy do |c|
        c.vm.box = "hardy32"
        c.vm.box_url = "http://dl.dropbox.com/u/6091/hardy32.box"
        c.vm.network :hostonly, "10.20.30.10"
        c.vm.host_name = "puppethardy.vagrant.local"
        c.vm.provision :shell do |shell|
            shell.path = "puppetclient-bootstrap.sh"
        end
    end

    config.vm.define :puppetlucid do |c|
        c.vm.box = "lucid32"
        c.vm.box_url = "http://files.vagrantup.com/lucid32.box"
        c.vm.network :hostonly, "10.20.30.11"
        c.vm.host_name = "puppetlucid.vagrant.local"
        c.vm.provision :shell do |shell|
            shell.path = "puppetclient-bootstrap.sh"
        end
    end

    config.vm.define :puppetprecise do |c|
        c.vm.box = "precise32"
        c.vm.box_url = "http://files.vagrantup.com/precise32.box"
        c.vm.network :hostonly, "10.20.30.12"
        c.vm.host_name = "puppetprecise.vagrant.local"
        c.vm.provision :shell do |shell|
            shell.path = "puppetclient-bootstrap.sh"
        end
    end
end
