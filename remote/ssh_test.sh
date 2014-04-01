#!/bin/sh

for host in `cut -d" " -f1 remote_hosts`; do
        ssh -o StrictHostKeyChecking=no root@$host "echo SSH to $host OK"
done
