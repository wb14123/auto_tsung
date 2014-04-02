#!/bin/sh

echo "### Backup config"
cp -v /etc/security/limits.conf /etc/security/limits.conf.bak
cp -v /etc/sysctl.conf /etc/sysctl.conf.bak
cp -v /etc/hosts /etc/hosts.bak
cp -v ~/.ssh/authorized_keys ~/.ssh/authorized_keys.bak

echo "### Config system"
echo "root   soft    nofile    1000000"  >> /etc/security/limits.conf
echo "root   hard    nofile    1000000"  >> /etc/security/limits.conf
echo "fs.file-max = 2000000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 1024 65000" >> /etc/sysctl.conf
sysctl -p

echo "### Config hosts"
cat remote_hosts /etc/hosts > hosts
mv -v hosts /etc/hosts

echo "### Config SSH"
cat remote_keys >> ~/.ssh/authorized_keys

echo "### Install erlang and tsung"
yes | yum install openssl* wx* unixODBC
yes | rpm -ivh esl-erlang_16.b.3-2~centos~6_amd64.rpm
tar -xf tsung-1.5.0.tar.gz
cd tsung-1.5.0
./configure
make -j`nproc`
make install
