#!/bin/bash

. /vagrant/puppetclient-bootstrap.sh

if $(dpkg -l | grep -q puppetmaster); then
    echo "puppetmaster already installed."
else
    echo "Installing puppetmaster..."
    aptitude -q -y install puppetmaster 
    update-rc.d puppetmaster enable
fi

if [ ! $(egrep '^autosign=' /etc/puppet/puppet.conf) ]; then
    echo "Setting master to autosign every certificate requests..."
    echo "autosign=true" >> /etc/puppet/puppet.conf
fi

if [ ! $(egrep '^certname=' /etc/puppet/puppet.conf) ]; then
    echo "Setting certname..."
    echo "certname=puppetmaster.vagrant.local" >> /etc/puppet/puppet.conf
fi

[ -x /vagrant/puppetmaster-code.sh ] && /vagrant/puppetmaster-code.sh

service puppetmaster restart

