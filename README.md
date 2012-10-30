vagrant-puppetdev
===================

Vagrant development environment for Puppet master/client on Ubuntu. 

The master is on a precise 32 bit and the three agents are hardy, 
lucid and precise, all on 32 bit architecture for maximum portability.
You can add other hosts as clients and mix them with different roles.

HOWTO START
-----------

1. Install GIT

`sudo aptitude install git`

2. Install [Vagrant](http://vagrantup.com/v1/docs/getting-started/index.html)

3. Create a vagrant environment

`mkdir ~/vagrant/puppetdev`

`git clone https://github.com/lorello/vagrant-puppetdev.git ~/vagrant/puppetdev`

4. Create config file to get puppet code from your repository

`cd ~/vagrant/puppetdev`

`cp puppetmaster-code-repository.conf.template puppetmaster-code-repository.conf`

Edit accordingly to your environment (you can use SVN or GIT) or leave it with 
suggested default if you want to start playing with an empty puppet master

5. Create your master instance

`vagrant up puppetmaster`

Wait until the boot process finish and the puppetmaster starts. Login to the host
and verify that `manifests` and `modules` are under `/etc/puppet` as expected.

6. Create your client instances

`vagrant up puppethardy`

`vagrant up puppetlucid`

`vagrant up puppetprecise`

Each host will boot and the run puppet agent for the first time, generating the SSL
certificate that the puppetmaster will [firm automatically](http://projects.puppetlabs.com/projects/1/wiki/certificates_and_security).


