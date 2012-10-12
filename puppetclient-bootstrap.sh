#!/bin/bash

MASTERNAME=puppetmaster.vagrant.local
OPTIONS="--user root --no-daemonize --onetime --detailed-exitcodes --logdest /var/log/puppet/agent.log --verbose"

DISTRO=$(lsb_release -c -s)

if [ ! -f puppetlabs-release-$DISTRO.deb ]; then
    echo "Downloading PuppetLabs release package"
    wget -q http://apt.puppetlabs.com/puppetlabs-release-$DISTRO.deb
fi

if $(dpkg -l | grep -q puppetlabs-release); then
    echo "PuppetLabs repositories package already installed."
else
    echo "Adding PuppetLabs repositories..."
     dpkg -i puppetlabs-release-$DISTRO.deb
fi

if $(dpkg --status puppet | egrep -q "^Version: 2.7"); then
    echo "puppet 2.x already installed."
else
    echo "Installing puppet agent..."

    if [ "$DISTRO" = "hardy" ]; then
        echo "Fixing puppetlabs repo problem on hardy, getting lucid repo"
        touch /etc/apt/sources.list.d/lucid.list
        chmod a+w /etc/apt/sources.list.d/lucid.list
        echo -e "deb http://us.archive.ubuntu.com/ubuntu/ lucid main restricted" >> /etc/apt/sources.list.d/lucid.list
    fi
    aptitude -q -y update
    export DEBIAN_FRONTEND=noninteractive
    apt-get install --yes --force-yes puppet=2.7.18-1puppetlabs1
fi

if $(grep -q puppetmaster.vagrant.local /etc/hosts); then
    echo "puppetmaster IP already present in /etc/hosts."
else
    echo "Setting puppetmaster IP in /etc/hosts"
    echo "10.20.30.2    puppetmaster.vagrant.local puppetmaster puppet" >> /etc/hosts
fi

/usr/bin/puppet agent $OPTIONS --server $MASTERNAME 

