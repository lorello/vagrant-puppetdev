vagrant-puppetdev
===================

Vagrant development environment for Puppet master/client on Ubuntu. 

The master is on a precise 32 bit and the three agents are hardy, 
lucid and precise, all on 32 bit architecture for maximum portability.

HOWTO START
-----------

1. Install GIT

`sudo aptitude install git`

2. Install [Vagrant](http://vagrantup.com/v1/docs/getting-started/index.html)

3. Clone the vagrantfiles

`git clone https://github.com/lorello/vagrant-puppetdev.git ~/vagrant/puppetdev`

4. Create config file to get puppet code from your repository

`cd ~/vagrant/puppetdev`

`cp puppetmaster-code-repository.conf.template puppetmaster-code-repository.conf`

Edit accordingly to your environment or leave it with suggested default if your just
start playing with puppet

TODO: 

 - simple puppet code in separated repository to start playing
with puppet recipes.




