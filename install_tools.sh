#!/usr/bin/env bash

#Go to https://golang.org/dl/

wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.12.6.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.bashrc
source $HOME/.bashrc

#Python
git clone https://github.com/pyenv/pyenv-installer
cd pyenv-installer
bash pyenv-installer

echo 'export PATH="~/.pyenv/bin:$PATH"' >> $HOME/.bashrc
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

#To install python
env PYTHON_CONFIGURE_OPTS="--enable-shared
                           --enable-optimizations
                           --with-computed-gotos
                           --with-lto
                           --enable-ipv6" pyenv install global 3.7.0
                           
env PYTHON_CONFIGURE_OPTS="--enable-shared
                           --enable-optimizations
                           --with-computed-gotos
                           --with-lto
                           --enable-ipv6" pyenv install local 3.7.0
