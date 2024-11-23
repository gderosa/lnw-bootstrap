#!/bin/sh

APP=lnw
REPONAME=$APP
GHUSER=gderosa

export DEBIAN_FRONTEND=noninteractive

dpkg --configure -a
apt-get -f install
apt-get -y update
apt-get -y upgrade
apt-get -y install git-core

cd /opt
git clone https://github.com/$GHUSER/$REPONAME.git
cd $REPONAME

sh scripts/setup.sh

