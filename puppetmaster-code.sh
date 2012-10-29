#!/bin/bash

if [ ! -f /vagrant/puppetmaster-code-repository.conf ]; then
    echo "if you want to checkout your puppet code customize the ./puppetmaster-code-repository.conf.template"
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
        svn co $SVNOPTIONS $REPO_MODULES $PATH_MODULES
        svn co $SVNOPTIONS $REPO_MANIFESTS $PATH_MANIFESTS
        ;;
    GIT)
        ensure_package git-core
        git clone $REPO_MODULES $PATH_MODULES
        git clone $REPO_MANIFESTS $PATH_MANIFESTS
        ;;
esac

