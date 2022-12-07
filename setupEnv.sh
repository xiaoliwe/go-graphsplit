#!/bin/bash
printf "\n"
echo "<------ Updating the OS enviroments ------>"
sudo apt update && apt upgrade -y

sleep 5
wait $!
printf "\n"
echo "<------ Installing liblwloc-dev and pkc-config ------>"
sudo apt install -y libhwloc-dev
sudo apt install -y pkg-config

sleep 2
wait $!
printf "\n"
echo "<------ Installing libIOpenCL ------>"
sudo ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/libOpenCL.so

if cat ~/.bashrc | grep 'export LD_LIBRARY_PATH'; then
    echo "LD_LIBRARAY_PATH has exists!"
else
    echo "export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/" >>~/.bashrc
fi
printf "\n"
echo "<------ Installing golang package ------>"
if cat ~/.bashrc | grep '/usr/local/go/bin'; then
    echo "golang has exists!"
else
    wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
    sleep 3
    wait $!
    sudo rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
    echo "export PATH=$PATH:/usr/local/go/bin" >>~/.bashrc
    sudo ldconfig

    echo "<------ Golang package finished! and remove golang package ------>"
    sudo rm -f go1.19.3.linux-amd64.tar.gz
fi

source ~/.bashrc
printf "\n"
echo "<------Begin to git submodule update ------>"
git submodule update --init --recursive

sleep 10
wait $!

make ffi && make

sleep 10
wait $!
echo "<------ All the packages has finished and Enviroment was setup!--->"
