#!/bin/bash

#NET_IN=enx4690bb615d3f
NET_IN=$1
NET_OUT=enp2s0

iptables -t nat -A POSTROUTING -o $NET_IN -j MASQUERADE
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $NET_OUT -o $NET_IN -j ACCEPT
