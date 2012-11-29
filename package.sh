
WHAT=$1



vagrant package puppetmaster --output puppetmaster-softec.box --vagrantfile Vagrantfile.package
echo mv -i puppetmaster-softec.box ~/Dropbox/VagrantBoxes/puppetdev/puppetmaster-softec.box
vagrant package puppetprecise --output ~/Dropbox/Public/vagrant-boxes/puppetprecise.box
vagrant package puppetlucid --output ~/Dropbox/Public/vagrant-boxes/puppetlucid.box
vagrant package puppethardy --output ~/Dropbox/Public/vagrant-boxes/puppethardy.box
