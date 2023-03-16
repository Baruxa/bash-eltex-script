#!/bin/bash

# Read IP addresses from output.txt file
mapfile -t ips < output_MES2324.txt

# Loop through the IP addresses
for ip in "${ips[@]}"; do
  echo "Saving configuration of $ip"

# Check if the device is reachable
if ping -c1 -w1 "$ip" >/dev/null; then
# Save current configuration
snmpset -v2c -c ctvwrite -t 3 -r 2 "$ip" \
1.3.6.1.4.1.89.87.2.1.3.1 i 1 \
1.3.6.1.4.1.89.87.2.1.7.1 i 2 \
1.3.6.1.4.1.89.87.2.1.8.1 i 1 \
1.3.6.1.4.1.89.87.2.1.12.1 i 3 \
1.3.6.1.4.1.89.87.2.1.17.1 i 4

    echo "Configuration of $ip saved successfully"
  else
    echo "Device $ip is unreachable, skipping configuration save"
  fi
done
