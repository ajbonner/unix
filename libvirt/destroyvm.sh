#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 <vm domain name>"
  exit 1
fi

virsh destroy $1
sleep 2
virsh undefine $1
sudo rm -rf /var/lib/libvirt/images/$1
