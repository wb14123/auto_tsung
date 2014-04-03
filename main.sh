#!/bin/sh

DIR=`pwd`

echo "## Clean files first"
rm $DIR/remote_hosts
rm $DIR/remote_keys

function trans() {
	host=$1
	echo "## Transform files to remote $host ..."
	scp -r -o StrictHostKeyChecking=no remote root@$host:~/
	echo "## Gather remote $host informations ..."
	ssh root@$host "sh remote/ip.sh" >> $DIR/remote_hosts
	yes | ssh root@$host "sh remote/gen_ssh.sh" >> $DIR/remote_keys
}

for host in `cat $DIR/hosts.conf`; do
	trans $host &
done; wait

cat ~/.ssh/id_rsa.pub >> $DIR/remote_keys

function sys() {
	host=$1
	echo "## Config remote $host ..."
	scp remote_hosts root@$host:~/remote
	scp remote_keys root@$host:~/remote
	ssh root@$host "cd ~/remote; sh sys.sh"
}
for host in `cat $DIR/hosts.conf`; do
	sys $host &
done; wait

for host in `cat $DIR/hosts.conf`; do
	echo "## Config and test SSH on $host ..."
	ssh root@$host "cd ~/remote; sh ssh_test.sh" &
done
