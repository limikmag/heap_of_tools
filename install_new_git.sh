#!/bin/bash


function install_git() {
   sudo yum update -y nss curl libcurl
   #yum install curl-devel #for centos
   #sudo apt-get install libcurl4-openssl-dev #for ubuntu
   wget https://github.com/git/git/archive/v2.21.0.tar.gz -O /tmp/git.tar.gz
   cd /tmp   
   tar -zxf git.tar.gz
   cd git-*
   make configure
   ./configure --prefix=/usr/local
   sudo make install
   git --version
   git config --global user.name "limikmag"
   git config --global user.email "limikmag@gmail.com"
   git config --list  
}

install_git
