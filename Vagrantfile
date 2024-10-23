 -*- mode: ruby -*-
# vi:set ft=ruby :

Vagrant.configure("2") do |config|
 config.vm.box = "rockylinux/9"
 config.vm.box_version = "4.0.0"
 config.vm.network "forwarded_port", guest: 80, host: 8080
 config.vm.provision "shell", inline: <<-SHELL

  sudo dnf -y update
  sudo dnf -y install nginx
  sudo systemctl start nginx
  sudo systemctl enable nginx
SHELL

  config.vm.provider "virtualbox" do |vb|
  vb.memory = "1024"
 end
end
