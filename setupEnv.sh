#!/bin/bash
printf "\n"
echo "<------ Updating the OS enviroments ------>"
sudo apt update && apt upgrade -y

sleep 5
wait $!

echo "<------ Installing liblwloc-dev and pkc-config ------>"
sudo apt install libhwloc-dev
sudo apt install pkg-config

sleep 2
wait $!

echo "<------ Installing libIOpenCL ------>"
sudo ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/libOpenCL.so
echo "export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/'" >>~/.bashrc

echo "<------ Installing golang package ------>"
wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
sleep 3
wait $!
sudo rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >>~/.bashrc
sudo ldconfig
source ~/.bashrc

echo "<------ Golang package finished! and remove golang package ------>"
sudo rm -f go1.19.3.linux-amd64.tar.gz

echo "<------Begin to git submodule update ------>"
git submodule update --init --recursive

sleep 10
wait $!

make ffi && make

sleep 10
wait $!
