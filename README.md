# Setup LNW

## Vagrant
```
vagrant up
```
Optional, second  VM, downstream device:
```
vagrant up lnwb
```

Also read the message from `vagrant up`.

## Physical machine
Install Debian 13 (trixie).

Run the script `kickoff.sh`.

A user `lnw` with password `lnw` will be created. App will be in `/opt/lnw`.

Then, start with

```
cd /opt/lnw
./scripts/start.sh  # if not already running as a service
```

## Environment variables (both physical and VM)

`BRANCH`: will checkout the particular Git branch in the machine.

With Vagrant, from a host with Bash-like shell, typycally Linux or macOS:
```
BRANCH=mybranch vagrant up --provision
```

Or (directly in the machine, possibly physical):

```
BRANCH=mybranch kickoff.sh
```
