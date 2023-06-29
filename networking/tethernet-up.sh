#!/bin/bash

#set -eu -o pipefail

if [ $UID != 0 ]; then
  echo "This script must be run as root!"
  exit 1
fi

BR_IFACE=br0
BR_CHILDREN=(
  enp3s0 
  enxa2d795eb3edc
)

brctl show $BR_IFACE > /dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "Adding bridge interface $BR_IFACE"
  brctl addbr $BR_IFACE 
fi

BR_CHILDREN_CUR=$(brctl show br0 | tail -n +2  | awk 'NF>1 {print $4} NF == 1 {print $1}')
for CHILD_IFACE in ${BR_CHILDREN[@]}; do
  FOUND=0
  for CUR_BR_CHILD in ${BR_CHILDREN_CUR[@]}; do
    if [ $CHILD_IFACE == $CUR_BR_CHILD ]; then
      FOUND=1
    fi
  done

  if [ $FOUND == 0 ]; then
    echo "Adding $CHILD_IFACE to $BR_IFACE"
    brctl addif $BR_IFACE $CHILD_IFACE
  fi
done

for CHILD_IFACE in ${BR_CHILDREN[@]}; do
  ip link set $CHILD_IFACE up
done
ip link set $BR_IFACE up
brctl setfd $BR_IFACE 0

echo "Tethering enabled on $BR_IFACE..."
