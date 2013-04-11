#!/bin/sh
vagrant up --no-provision || exit 1

if [ `which parallel 2> /dev/null` ]; then
  grep config.vm.define Vagrantfile | sed  's/^.*:\([^ ]\+\) .*$/\1/' | \
    parallel -j0 -u vagrant provision '{}'
else
  echo
  echo -e " \e[31;1mInstall GNU parallel to provision in parallel...\e[0m"
  echo
  vagrant provision
fi
