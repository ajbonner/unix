#!/bin/bash

set -eu

if [ $# -lt 3 ] || [ ! -f $2 ]; then
  echo "Usage $0 <img url> <cloud-init config file> <images destination>"
  echo "  $0 http://cloud-images.ubuntu.com/releases/xenial/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img cloud-config-data /tmp"
  exit 1
fi

img_url="$1"
cloud_data="$2"
img_dest="$3"
img_file=$(basename $img_url)
checksum_url="$(dirname $img_url)/SHA1SUMS"

if [ ! -d $img_dest ]; then
  mkdir -p $img_dest
fi

remote_checksum=$(wget -q $checksum_url -O - | grep $img_file | awk '{ print $1 }')
if [ -e $img_dest/$img_file ]; then 
  local_checksum=$(sha1sum $img_dest/$img_file | awk '{ print $1 }')
  ## download the image
  if [[ $remote_checksum != $local_checksum ]]; then
    echo "Checksum mismatch [remote: $remote_checksum, local: $local_checksum]"
    echo "Image exists but checksum validation failed...re-downloading image"
    wget $img_url -O $img_dest/$img_file
  fi
else
    echo "Image does not exist...downloading image"
    wget $img_url -O $img_dest/$img_file
fi

local_checksum=$(sha1sum $img_dest/$img_file | awk '{ print $1 }')
if [[ $remote_checksum != $local_checksum ]]; then
  echo "Download failed checksum mismatch [remote: $remote_checksum, local: $local_checksum]"
  exit 1
fi

## Convert the compressed qcow file downloaded to a uncompressed qcow2
qemu-img convert -O qcow2 $img_dest/$img_file $img_dest/disk.img.orig

## create the disk with NoCloud data on it.
cloud-localds $img_dest/config.img $cloud_data

## Create a delta disk to keep our .orig file pristine
qemu-img create -f qcow2 -b $img_dest/disk.img.orig $img_dest/disk.img
qemu-img rebase -b disk.img.orig $img_dest/disk.img -u # needed as backing file is explicitly written with $img_dest in path

echo "Done"
