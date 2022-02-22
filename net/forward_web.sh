#!/bin/bash

sudo iptables -t nat -I PREROUTING 1 -d 192.168.0.2 -p tcp --dport 443 -m comment --comment "mns.dev/focal 443 port forwarding dst" -j DNAT --to-destination 192.168.36.10:443
sudo iptables -t nat -I POSTROUTING 1 -s 192.168.0.0/24 -d 192.168.36.10 -p tcp -m tcp --dport 443 -m comment --comment "mns.dev/focal 443 port forwarding src" -j SNAT --to-source 192.168.36.1
sudo iptables -R LIBVIRT_FWI 1 -d 192.168.36.0/24 -o virbr2 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
