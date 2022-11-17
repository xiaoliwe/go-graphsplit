#!/bin/bash

#install liblwloc-dev
sudo apt install libhwloc-dev

sleep 5
wait $!

#install libIOpenCL
sudo ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/libOpenCL.so
#result=''
if ！ command -v 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/"' &> /dev/null 
then 
    echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/"' >> ~/.bashrc
    exit
fi

sudo ldconfig

#Setup the ~/.bashrc and user's env

wait $!
echo '++++++++ Installing golang package....++++++'
#Install golang package
wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz 

sleep 10
wait $!

rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo '+++++++ Golang package finished !+++++++'

echo '+++++++++ build repos....+++++++'
#build repos
git submodule update --init --recursive

sleep 10
wait $!

make ffi && make


