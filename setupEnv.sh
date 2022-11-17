#!/bin/bash

#install liblwloc-dev
sudo apt install libhwloc-dev
wait $!

sudo apt install pkg-config
wait $!

#install libIOpenCL
sudo ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/libOpenCL.so
echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/"' >> ~/.bashrc
sudo ldconfig

#Setup the ~/.bashrc and user's env
echo '++++++++ Installing golang package....++++++'
#Install golang package
wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz 

echo '+++++++ installing golang package...+++++++'

sleep 10
wait $!
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

echo '+++++++ Golang package finished !+++++++'


echo '+++++++++ Begin to build repos....+++++++'
#build repos
git submodule update --init --recursive

sleep 10
wait $!

make ffi && make

sleep 10
wait $!

