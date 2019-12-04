#!/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get --assume-yes install g++ build-essential openssh-server nfs-common mpich
