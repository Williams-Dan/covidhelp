# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

REQUIRED_PLUGINS = %w[vagrant-vbguest].freeze

plugins_to_install = REQUIRED_PLUGINS.reject { |plugin| Vagrant.has_plugin? plugin }
unless plugins_to_install.empty?
  puts "Installing required plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort 'Installation of one or more plugins has failed.'
  end
end

Vagrant.configure('2') do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = 'hashicorp/bionic64'
  config.vm.box_version = '1.0.282'

  config.vm.provider 'virtualbox' do |vb|
    vb.name = 'Covid-Help'
    vb.gui = false
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']
    vb.customize ['modifyvm', :id, '--accelerate3d', 'off']
    vb.customize ['modifyvm', :id, '--vram', '128']
    vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
    vb.customize ['modifyvm', :id, '--memory', '4096']
    vb.customize ['modifyvm', :id, '--hwvirtex', 'on']
  end

  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
     sudo apt-get update -y
     sudo apt-get install -y zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https gcc make
     sudo apt update -y
     sudo apt install mariadb-server -y
     systemctl status mariadb
     set +H
     sudo /usr/bin/mysqladmin -u root password 'password'
     sudo mysql -u root -ppassword -e "create user covid_help_app@localhost identified by 'password1!';"
     sudo mysql -u root -ppassword -e "create database covidhelp;"
     sudo mysql -u root -ppassword -e "grant all privileges on covidhelp.* to 'covid_help_app'@localhost;"
     sudo mysql -u root -ppassword -e "flush privileges;"
     sudo apt install -y libmariadb-dev
     sudo apt install ubuntu-gnome-desktop -y
     systemctl status gdm
     git clone https://github.com/rbenv/rbenv.git /home/vagrant/.rbenv
     echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bashrc
     echo 'eval "$(rbenv init -)"' >> .bashrc
     git clone https://github.com/rbenv/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
     echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/vagrant/.bashrc
     git clone https://github.com/rbenv/rbenv-vars.git /home/vagrant/.rbenv/plugins/rbenv-vars
     sudo chown -R vagrant:vagrant /home/vagrant/.rbenv
     sudo chown vagrant:vagrant /home/vagrant/.bashrc
     source /home/vagrant/.bashrc
     /home/vagrant/.rbenv/bin/rbenv install 2.7.0
     /home/vagrant/.rbenv/bin/rbenv global 2.7.0
     sudo shutdown
  SHELL
end
