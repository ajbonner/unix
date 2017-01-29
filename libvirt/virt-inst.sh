#!/bin/bash

#
# domain name should be a fqdn e.g. vmhost.somedomain.com
# disk image source should be a directory containing 1 or more disk.img files
# and a cloud-init seed image named config.img
#
if [ $# -lt 2 ]; then
  echo "Usage $0 <domain name> <disk image source>"
  exit 1
fi

GUEST=$1
IMAGE_SRC=$2
IMAGE_DEST="/var/lib/libvirt/images/${GUEST}"
VMEM=8192
VCPUS=2
VROOTSIZE=60G
NETWORK="bridge=virbr0,model=virtio"

sudo mkdir -p $IMAGE_DEST
sudo qemu-img resize $IMAGE_SRC/disk.img +${VROOTSIZE}
sudo cp $IMAGE_SRC/disk.img* $IMAGE_DEST
sudo cp $IMAGE_SRC/config.img $IMAGE_DEST
sudo chown libvirt-qemu:kvm $IMAGE_DEST/*.img*

virt-install \
  --name ${GUEST} \
  --ram ${VMEM} \
  --vcpus=${VCPUS} \
  --autostart \
  --memballoon virtio \
  --network ${NETWORK} \
  --boot hd \
  --disk path=/var/lib/libvirt/images/${GUEST}/disk.img,format=qcow2,bus=virtio \
  --disk path=/var/lib/libvirt/images/${GUEST}/config.img,bus=virtio \
  --noautoconsole
