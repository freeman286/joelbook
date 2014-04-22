# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$bootstrap = <<SCRIPT
echo ">>>>> Udpating..."
sudo apt-get -y update
sudo apt-get -q -y install libxslt-dev libxml2-dev imagemagick libmagickwand-dev nodejs
echo ">>>>> Installing postgresql..."
export DEBIAN_FRONTEND=noninteractive 
sudo apt-get -q -y install postgresql-9.1
sudo apt-get -q -y install libpq-dev
sudo su postgres -c psql <<< "CREATE ROLE vagrant SUPERUSER LOGIN;"

echo ">>>>> Installing redis..."
sudo apt-get install redis-server

echo ">>>>> Installing RVM..."
sudo apt-get -q -y install git-core curl
curl -L https://get.rvm.io | bash -s stable
source /home/vagrant/.rvm/scripts/rvm
echo ">>>>> Installing RUBY..."
source /usr/local/rvm/scripts/rvm
rvm requirements
rvm install ruby-1.9.3

echo ">>>>> Bundling..."
cd /vagrant
bundle

echo ">>>>> Creating database..."
rake db:create
rake db:migrate

echo ">>>>> Installing NPM things..."
cd realtime
sudo apt-get -q -y install npm
npm config set registry http://registry.npmjs.org/
npm install socket.io
npm install redis
cd ..


echo  ">>>>> Finished!"
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise32"
  config.vm.network :forwarded_port, guest: 3306, host: 4000 # MySQL
  config.vm.network :forwarded_port, guest: 3000, host: 3000 # Rails
  config.vm.network :forwarded_port, guest: 5001, host: 5001 # NodeJS
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
	  v.cpus = 4
  end
  config.vm.provision :shell, inline: $bootstrap, :privileged => false
end
