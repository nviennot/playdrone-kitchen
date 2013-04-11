#!/bin/bash
IMG=ubuntu-12.10-server-amd64
bundle
bundle exec veewee vbox build $IMG -a
bundle exec veewee vbox validate $IMG || exit 1
bundle exec veewee vbox export $IMG || exit 1
vagrant box add $IMG $IMG.box || exit 1
exec ./provision.sh
