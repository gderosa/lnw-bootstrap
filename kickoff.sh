#!/bin/sh

# ENVIRONMENT:
# BRANCH: target app git branch to be checked out

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
# BRANCH might be passed as env variable, checkout to it if var is not empty
if [ ! -z "$BRANCH" ]; then
    echo "Checking out branch $BRANCH"
    git checkout $BRANCH
fi

sh scripts/setup.sh

