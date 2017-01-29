#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 domain name"
    exit 1
fi

arp -n | grep $(virsh dumpxml $1 | grep -oP "mac address='\K([[0-9a-fA-F:]+)") | awk '{ print $1 }'
