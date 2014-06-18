#!/bin/bash

for i in `seq -w 1 16`; do
  knife solo cook root@node$i.playdrone.io nodes/node$i.json &
done

wait
