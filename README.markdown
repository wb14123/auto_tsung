
This is a collection of scripts to auto deploy [tsung](http://tsung.erlang-projects.org) eviroment to many hosts.

Requires
------------------

* You must be able to login to the hosts through SSH with keys. (Or you must input the password manually).
* The hosts must be able to visit each other throght the ip binded on `eth0`.
* Must use `yum` as package manager for now.
* The hosts must have a hostname and could be get from `$HOSTNAME`.


How to use
------------------

1. Write host ips into `hosts.conf`, one ip per line.
2. Config yum repo in `remote/CentOS-Base-custom.repo`, or just delete the file if you do not want to custom it.
3. Run `./main.sh`
4. When you use `Ctrl+C` to stop, some programs may also run in the background. Logout the shell to stop them all.


TODO
-------------------

* More package maangers.
* Clean duplicate lines in remote config files, such as `/etc/hosts`.
* Transform files between hosts to make it faster since it is in a LAN.
* Transform the binary tsung files instead of source file.
