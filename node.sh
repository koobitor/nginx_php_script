#!/bin/bash

sudo su
sudo yum update -y
curl --silent --location https://rpm.nodesource.com/setup | bash -
yum -y install nodejs
yum groupinstall 'Development Tools'

# Port 3000 to 80
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3000