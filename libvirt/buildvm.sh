#!/bin/bash

VM_HOSTNAME=$1

if [ $# -lt 1 ]; then
  echo "Usage $0 hostname"
  exit 1
fi

sudo vmbuilder kvm ubuntu \
    --tmpfs - \
    --dest=/var/lib/libvirt/images/$VM_HOSTNAME \
    --overwrite \
    --mem=8192\
    --cpus=1 \
    --rootsize=60G \
    --swapsize=2048 \
    --addpkg=linux-image-generic \
    --addpkg=openssh-server \
    --addpkg=vim \
    --addpkg=cron \
    --addpkg=acpid \
    --arch=amd64 \
    --suite=trusty \
    --flavour virtual \
    --components main,universe,restricted \
    --hostname $VM_HOSTNAME \
    --libvirt qemu:///system \
    --bridge=virbr0;

