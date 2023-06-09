#!/bin/bash

# Создаем файл ip_list.txt с правами записи
touch ip_list.txt && chmod 666 ip_list.txt

subnets="172.31.97.0/21 10.204.18.0/24 10.204.19.0/24 10.202.0.0/24 10.200.0.0/24 10.204.10.0/24 10.204.8.0/24 10.204.6.0/23 10.204.0.0/23 10.204.4.0/23 10.204.14.0/24 10.204.12.0/23 10.204.2.0/24 10.204.15.0/24 10.204.16.0/23 10.1.0.0/24" # здесь указываем список подсетей, которые нужно пинговать
filename="ip_list.txt"  # здесь указываем имя файла, куда будут записываться результаты пингования

# Перебираем подсети
for subnet in $subnets; do
    # Получаем список IP-адресов в подсети с помощью nmap
    for ip in $(nmap -sn "$subnet" | grep "Nmap scan report" | awk '{print $5}'); do
        # Выполняем пинг IP-адреса
        if ping -c 1 "$ip" &> /dev/null; then
            # IP-адрес доступен, записываем его в файл
            echo "$ip" >> "$filename"
        fi
    done
done
