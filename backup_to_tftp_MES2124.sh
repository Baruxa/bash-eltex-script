#!/bin/bash

# Read IP addresses from output.txt file
mapfile -t ips < output_MES2124.txt

# Loop through the IP addresses
for ip in "${ips[@]}"; do
  echo "Backing up configuration of $ip"

# Check if the device is reachable
if ping -c1 -w1 "$ip" >/dev/null; then

# Set SNMP parameters for backup
snmpset -v2c -c ctvwrite -t 3 -r 2 $ip \
1.3.6.1.4.1.89.87.2.1.3.1 i 1 \
1.3.6.1.4.1.89.87.2.1.7.1 i 3 \
1.3.6.1.4.1.89.87.2.1.8.1 i 3 \
1.3.6.1.4.1.89.87.2.1.9.1 a 10.1.0.102 \
1.3.6.1.4.1.89.87.2.1.11.1 s "/ems/backupbyscript/$ip.cfg" \
1.3.6.1.4.1.89.87.2.1.17.1 i 4
    echo "Backup of $ip completed successfully"
  else
    echo "Device $ip is unreachable, skipping backup"
  fi
done
