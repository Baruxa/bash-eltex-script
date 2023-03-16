#!/bin/bash

# Указываем путь к файлам
input_file="ip_list.txt"
output_file="output_MES2124.txt"

# Читаем файл построчно
while read ip; do
# Получаем ответ SNMP
snmp_response=$(snmpwalk -v2c -c ctvread "$ip" 1.3.6.1.2.1.1.1.0)

# Проверяем, содержит ли ответ текст MES2124
if [[ "$snmp_response" == *"MES2124"* ]]; then
    # Записываем IP-адрес в выходной файл
    echo "$ip" >> "$output_file"
fi
done < "$input_file"
