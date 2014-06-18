#!/bin/bash

for i in `seq -w 2 16`; do
  sed -e "s/\"set_fqdn\":.*/\"set_fqdn\": \"node$i\",/" node01.json > node$i.json
done
