#!/bin/bash

MASTERNAME=puppetmaster.vagrant.local
MASTERIP=10.20.30.2
VERSION=2.7.18-1puppetlabs1
TIMEZONE="Europe/Rome"
DISTRO=$(lsb_release -c -s)

ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

if [ ! -f puppetlabs-release-$DISTRO.deb ]; then
    echo "Downloading PuppetLabs release package"
    wget -q http://apt.puppetlabs.com/puppetlabs-release-$DISTRO.deb
fi

if $(grep -q $MASTERIP /etc/hosts); then
    echo "Master IP already present in /etc/hosts."
else
    echo "Setting puppetmaster IP in /etc/hosts"
    echo "$MASTERIP     $MASTERNAME puppet" >> /etc/hosts
fi

if $(dpkg -l | grep -q puppetlabs-release); then
    echo "PuppetLabs repositories package already installed."
else
    echo "Adding PuppetLabs repositories..."
    dpkg -i puppetlabs-release-$DISTRO.deb
fi

if $(dpkg --status puppet | egrep -q "^Version: $VERSION"); then
    echo "puppet $VERSION already installed."
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
    apt-get install --yes --force-yes puppet-common=$VERSION puppet=$VERSION
    [ -f /etc/apt/sources.list.d/lucid.list ] && rm -f /etc/apt/sources.list.d/lucid.list
fi



