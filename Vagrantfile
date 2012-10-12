# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.define :puppetmaster do |master_config|
        master_config.vm.box = "precise32"

        master_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
        # master_config.vm.box_url = "http://vagrantboxes.softecspa.it/puppetmaster.box"
        master_config.vm.network :hostonly, "10.20.30.2"
        master_config.vm.host_name = "puppetmaster.vagrant.local"

        master_config.vm.provision :shell do |shell|
            shell.path = "puppetmaster-bootstrap.sh"
        end

        master_config.vm.customize ["modifyvm", :id, "--memory", 512]

        # Tried this to download packages onetime, not running
        # master_config.vm.share_folder 'aptcache', '/var/cache/apt/archives', '/var/cache/apt/archives', :extra => 'uid=0,dmode=775,fmode=664' 
    end

    config.vm.define :puppethardy do |hardy_config|
        hardy_config.vm.box = "hardy32"
        hardy_config.vm.box_url = "http://dl.dropbox.com/u/6091/hardy32.box"
        # master_config.vm.box_url = "http://vagrantboxes.softecspa.it/puppethardy.box"
        hardy_config.vm.network :hostonly, "10.20.30.10"
        hardy_config.vm.host_name = "puppethardy.vagrant.local"

        # Provisioning 1: using this to create vagrant box
        hardy_config.vm.provision :shell do |shell|
            shell.path = "puppetclient-bootstrap.sh"
        end

        # Provisioning 2: using this in the distributed box
        #hardy_config.vm.provision :puppet_server do |puppet|
        #    puppet.puppet_server = "puppetmaster.vagrant.local"
        #    puppet.puppet_node = "puppethardy.vagrant.local"
        #    puppet.options = [ "--user", "puppet", "--no-daemonize", "--onetime", "--detailed-exitcodes", "--logdest", "/var/log/puppet/agent.log", "--verbose" ]
        #end
    end

    config.vm.define :puppetlucid do |lucid_config|
        lucid_config.vm.box = "lucid32"
        lucid_config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
        # master_config.vm.box_url = "http://vagrantboxes.softecspa.it/puppetlucid.box"
        lucid_config.vm.network :hostonly, "10.20.30.11"
        lucid_config.vm.host_name = "puppetlucid.vagrant.local"
        lucid_config.vm.provision :shell do |shell|
            shell.path = "puppetclient-bootstrap.sh"
        end
    end

    config.vm.define :puppetprecise do |precise_config|
        precise_config.vm.box = "precise32"
        precise_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
        # master_config.vm.box_url = "http://vagrantboxes.softecspa.it/puppetprecise.box"
        precise_config.vm.network :hostonly, "10.20.30.12"
        precise_config.vm.host_name = "puppetprecise.vagrant.local"

        precise_config.vm.provision :shell do |shell|
            shell.path = "puppetclient-bootstrap.sh"
        end
    end

end
