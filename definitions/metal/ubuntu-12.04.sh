#!/bin/bash

HOST=$1

echo '
mkdir -p ~/.ssh
echo ssh-dss AAAAB3NzaC1kc3MAAACBAK5SBB6QW4lr6MCbn/YCFeH77VD4Qbbd8v94dwMIqS4P6iZ6tVGYS5hexzCZIrUf8Yiov82xnfqK5s6yzHjgm3zFTKl486FWVp8Qk1FxqcjZ2IjvSJWZQ+y6kEBqpQ6BZuEdd08CsJ2uAvTPyyGIkgT8lD0lQb15HGyOhuYNAsf5AAAAFQDlTKPx/qpvs7WwJJtf59j38nJXdwAAAIEAnAWD5CLwX/yqfv6V4Mq4V7wjt1j0uTLt/8YsogHZvrbHzoVdBvawwPkPm7wVUNY1Ixpi3ZrxFcU0u/iogaGTPVqHFTUXcLmpkbhTEA7NA+cN2+5QELp38zfZ84+TuLs+0ng4cgn79wmzvV/2TWA79Mc+R03VplYZWqeaWCFqWsoAAACAFmUE1+7qu4dlaMgxW8/MHtSn+tTmuiKoFWnm5kxDStUFZ2Lk1qPbpl6/zfU51sQBo1dvEweVo3N6Qss6Jx8p+niXr9P5PSKAezIHhv5cZPUtlDS60PzO2X+9YOXLmrknRbZ5w9lb0/qxRfe/hGedkBGF1OBz7dZbfN8eS8mor3Y= pafy@home > ~/.ssh/authorized_keys
apt-get -y update
apt-get -y upgrade
apt-get -y install linux-headers-$(uname -r) build-essential
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev
apt-get -y install vim-nox
apt-get clean

# Install Ruby from packages
apt-get -y install ruby1.9.1 rubygems ruby1.9.1-dev
sudo update-alternatives --set ruby /usr/bin/ruby1.9.1
sudo update-alternatives --set gem /usr/bin/gem1.9.1

# Installing chef & Puppet
gem install chef puppet --no-ri --no-rdoc
' | ssh root@$HOST bash -s
