#!/bin/bash

if [ ! -f /vagrant/puppetmaster-code-repository.conf ]; then
    echo "if you want to checkout your puppet code customize the /vagrant/puppetmaster-code-repository.conf.template"
    exit 0
fi

. /vagrant/puppetmaster-code-repository.conf

function ensure_package()
{
    if $(dpkg -l | grep -q $1); then
        echo "$1 already installed."
    else
        echo "Installing $1..."
        aptitude -q -y install $1
    fi
}

case $VCS in
    SVN)
        ensure_package subversion
        [ -n $SVNUSER ] && SVNOPTIONS="$SVNOPTIONS --username $SVNUSER"
        [ -n $SVNPASS ] && SVNOPTIONS="$SVNOPTIONS --password $SVNPASS"
        [ -n $REPO_MODULES ] && [ -n $PATH_MODULES ] && svn co $SVNOPTIONS $REPO_MODULES $PATH_MODULES
        [ -n $REPO_MANIFESTS ] && [ -n $PATH_MANIFESTS ] && svn co $SVNOPTIONS $REPO_MANIFESTS $PATH_MANIFESTS
        ;;
    GIT)
        ensure_package git-core
        if [[ -n $REPO_MODULES && -n $PATH_MODULES ]]; then
		[ -d $PATH_MODULES ] && mv $PATH_MODULES $PATH_MODULES.original
		git clone $REPO_MODULES $PATH_MODULES
	fi
        if [[ -n $REPO_MANIFESTS && -n $PATH_MANIFESTS ]]; then
		[ -d $PATH_MANIFESTS ] && mv $PATH_MANIFESTS $PATH_MANIFESTS.original
		git clone $REPO_MANIFESTS $PATH_MANIFESTS
	fi
        ;;
    *)
        [ -d /etc/puppet/modules ] && mv /etc/puppet/modules /etc/puppet/modules.orig
        [ ! -h /etc/puppet/modules ] && ln -s /vagrant/puppet/modules /etc/puppet/modules

        [ -d /etc/puppet/manifests ] && mv /etc/puppet/manifests /etc/puppet/manifests.orig
        [ ! -h /etc/puppet/manifests ] && ln -s /vagrant/puppet/manifests /etc/puppet/manifests
esac

