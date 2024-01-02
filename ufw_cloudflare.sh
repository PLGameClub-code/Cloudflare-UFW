#!/bin/sh

PORTS="80,443" # Here insert ports to be available from cloudflare (like HTTP or HTTPS)

# Remove old rules
echo 'Removing old rules...'
ufw show added | grep 'Cloudflare IP' | awk '{ gsub("ufw","ufw delete",$0); system($0)}'

# Add new rules
echo 'Adding new rules...'
for cfip in `curl -sw '\n' https://www.cloudflare.com/ips-v{4,6}`; do ufw allow proto tcp from $cfip to any port $PORTS comment 'Cloudflare IP'; done

# Reload and show rule list
ufw reload
echo 'Done!'
ufw status verbose | grep -E 'Cloudflare IP|To|--'
