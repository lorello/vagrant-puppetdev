# Fork me and start playing
node 'puppethardy.vagrant.local' inherits generic_host {

}

node 'puppetlucid.vagrant.local' inherits generic_host {

}

node 'puppetprecise.vagrant.local' inherits generic_host {

}

node 'puppetmaster.vagrant.local' inherits generic_host {
  package { 'vim':
    ensure => present,
  }
  package { 'vim-puppet':
    ensure => present,
  }
  package { 'puppet-lint':
    ensure => present
  }
}

node generic_host {
  package { 'etckeeper':
    ensure => present
  }
}
