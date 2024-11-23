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
