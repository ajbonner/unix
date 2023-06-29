#!/bin/bash

set -eu

if [ $UID != 0 ]; then
  echo "This script must be run as root!"
  exit 1
fi

ip link set br0 down
brctl delbr br0
ip link set enp3s0 down
ip link set enxa2d795eb3edc down

