#!/bin/bash

set -eu

auth_email="" # Account email
zone_identifier="" # Log in to Cloudflare, select domain, copy "Zone ID" from Overview
auth_key="" #Below "Zone ID", click "Get your API key" and copy the global key
record_name="" # example.com
log_file="$HOME/bin/cloudflare_ip.log"
ip=$(curl -s v4.ident.me)

log() {
    if [ "$1" ]; then
        echo -e "[$(date)] - $1" >> $log_file
    fi
}

recordA_ip=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records?name=$record_name&type=A" -H "X-Auth-Email: $auth_email" -H "X-Auth-Key: $auth_key" -H "Content-Type: application/json" | jq '.result[0].content' -r)

if [[ $ip == $recordA_ip ]]; then
    exit 0
fi

recordA_identifier=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records?name=$record_name&type=A" -H "X-Auth-Email: $auth_email" -H "X-Auth-Key: $auth_key" -H "Content-Type: application/json" | jq '.result[0].id' -r)

#Update when A different
if [[ $ip != $recordA_ip ]]; then
    update=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records/$recordA_identifier" -H "X-Auth-Email: $auth_email" -H "X-Auth-Key: $auth_key" -H "Content-Type: application/json" --data "{\"id\":\"$zone_identifier\",\"type\":\"A\",\"name\":\"$record_name\",\"content\":\"$ip\"}")
    if [[ $update == *"\"success\":false"* ]]; then
        message="API UPDATE FAILED. DUMPING RESULTS:\n$update"
        log "$message"
        echo -e "$message"
        exit 1 
    else
        message="IPv4 changed to: $ip"
        log "$message"
    fi
fi
