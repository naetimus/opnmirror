#!/usr/bin/env bash

MIRROR="mirror.wdc1.us.leaseweb.net"
LOCAL_MIRROR="/var/www/html/opnsense"
REPOPATH="opnsense"

# Determine latest major FreeBSD release offered
RELEASE=$(rsync rsync://${MIRROR}/${REPOPATH}/ |& \
	grep FreeBSD | grep amd64 | tail -1 | awk '{print $5}')
REPOPATH="${REPOPATH}/$RELEASE"

# Determine latest opnsense release offered
REV=$(rsync rsync://${MIRROR}/${REPOPATH}/ |& \
	grep -v snapshots | tail -1 | awk '{print $5}')

# Retrieve the repository, using as much local information as is available (-y)
rsync --archive -Py \
	--exclude=LibreSSL \
	--exclude=libressl \
  --exclude=FreeBSD:10:amd64/
  --exclude=FreeBSD:10:i386/
  --exclude=FreeBSD:11:amd64/
  --exclude=FreeBSD:11:armv6/
  --exclude=FreeBSD:11:i386/
  --exclude=FreeBSD:12:amd64/
  --exclude=releases/19.1/
  --exclude=releases/19.7/
  --exclude=releases/20.1/
  --exclude=releases/21.7/
  --exclude=releases/22.1/
  --exclude=releases/22.7/
  --exclude=releases/23.1/
  --exclude=releases/23.7/
	--hard-links \
	--numeric-ids \
	--stats \
 rsync://${MIRROR}/${REPOPATH}/$REV ${LOCAL_MIRROR}/${REPOPATH}


