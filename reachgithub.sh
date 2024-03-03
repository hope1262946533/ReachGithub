#!/bin/bash
hosts_file="/etc/hosts"
hostname="github.com"

# 发送HTTP请求并提取IP地址
ip_address=$(curl -s https://sites.ipaddress.com/github.com/ | grep -oP '(?<=<a href="https:\/\/www\.ipaddress\.com\/ipv4\/)[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+(?=">)' | head -n 1)
# ip_address="140.82.112.3"

echo "Ip address of ${hostname} is: "${ip_address}

# 检查是否已存在github.com的条目
content=$(sudo grep "${hostname}" ${hosts_file} | wc -l)
if [ ${content} == 0 ] ; then
    sudo echo -e "\n${ip_address} ${hostname}" >> ${hosts_file}
else
    sudo sed -i "/ github.com/s/.*/${ip_address} github.com/" ${hosts_file}
fi

# echo "已将IP地址写入 ${hosts_file} 文件"
echo "Ip address of github.com stored into ${hosts_file}"
