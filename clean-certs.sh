#!/bin/bash
PUPPETHOSTS="puppethardy.vagrant.local puppetlucid.vagrant.local puppetprecise.vagrant.local"
for PUPPET_HOST in $PUPPETHOSTS; do
    HOST_CERT=/var/lib/puppet/ssl/ca/signed/$PUPPET_HOST.pem
    if [ -f $HOST_CERT ]; then
        echo "Cleaning certificates for $PUPPET_HOST"
        puppetca --clean $PUPPET_HOST
    fi
done

echo "Run on the client:"
echo "find /var/lib/puppet/ssl/ -type f -print0 |xargs -0r rm"
