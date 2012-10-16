#!/bin/bash

DISTRO=$(lsb_release -c -s)
PUPPETHOSTS="puppethardy.vagrant.local puppetlucid.vagrant.local puppetprecise.vagrant.local"

if [ ! -f puppetlabs-release-$DISTRO.deb ]; then
    echo "Downloading PuppetLabs release package"
    wget -q http://apt.puppetlabs.com/puppetlabs-release-$DISTRO.deb
fi

if $(dpkg -l | grep -q puppetlabs-release); then
    echo "PuppetLabs repositories package already installed."
else
    echo "Adding PuppetLabs repositories..."
    dpkg -i puppetlabs-release-$DISTRO.deb
    update-rc.d puppetmaster enable
fi

if $(dpkg -l | grep -q puppetmaster); then
    echo "puppetmaster already installed."
else
    echo "Installing puppetmaster..."
    aptitude -q -y install puppetmaster 
fi

if [ ! $(egrep '^autosign=' /etc/puppet/puppet.conf) ]; then
    echo "Setting master to autosign every certificate requests..."
    echo "autosign=true" >> /etc/puppet/puppet.conf
fi

if [ ! $(egrep '^certname=' /etc/puppet/puppet.conf) ]; then
    echo "Setting certname..."
    echo "certname=puppetmaster.vagrant.local" >> /etc/puppet/puppet.conf
fi

for PUPPET_HOST in $PUPPETHOSTS; do
    HOST_CERT=/var/lib/puppet/ssl/ca/signed/$PUPPET_HOST.pem
    if [ -f $HOST_CERT ]; then
        echo "Cleaning certificates for $PUPPET_HOST"
        puppetca --clean $PUPPET_HOST
    fi
done

[ -x ./puppetmaster-code.sh ] && ./puppetmaster-code.sh

service puppetmaster reload

