#!/usr/bin/env sh
set -ex
cd /tmp

apk upgrade
apk update

apk add curl ca-certificates nmap socat bash docker python py-pip

# CLI interfaces to popular hosts
#pip upgrade pip

pip install tutum
pip install awscli
pip install tugboat

apk del py-pip
rm -rf /tmp/*
rm -rf /var/cache/apk/*