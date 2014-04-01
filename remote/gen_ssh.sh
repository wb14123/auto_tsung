#!/bin/sh

ssh-keygen -f ~/.ssh/id_rsa -P "" &> /dev/null
cat ~/.ssh/id_rsa.pub
