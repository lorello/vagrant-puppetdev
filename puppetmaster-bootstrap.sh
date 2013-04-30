#!/bin/bash

. /vagrant/puppetclient-bootstrap.sh

if $(dpkg --status puppetmaster | egrep -q "^Version: $VERSION"); then
    echo "puppetmaster already installed."
else
    echo "Installing puppetmaster..."
    aptitude -q -y install puppetmaster=$VERSION puppetmaster-common=$VERSION
    update-rc.d puppetmaster enable
fi

if $(dpkg -l | grep -q rubygems); then
    echo "rubygems already installed."
else
    echo "Installing rubygems..."
    aptitude -q -y install rubygems
fi

if [ ! $(egrep '^autosign=' /etc/puppet/puppet.conf) ]; then
    echo "Setting master to autosign every certificate requests..."
    echo "autosign=true" >> /etc/puppet/puppet.conf
fi

if [ ! $(egrep '^certname=' /etc/puppet/puppet.conf) ]; then
    echo "Setting certname..."
    echo "certname=puppetmaster.vagrant.local" >> /etc/puppet/puppet.conf
fi

if  [ ! -f /usr/lib/ruby/1.8/json.rb ]; then
    echo "Setting up json library for puppetmaster"
    gem install -i /usr/lib/ruby/1.8/ json
    cp -a /usr/lib/ruby/1.8/gems/json-1.7.7/lib/json* /usr/lib/ruby/1.8/
fi


[ -x /vagrant/puppetmaster-code.sh ] && /vagrant/puppetmaster-code.sh

service puppetmaster restart

