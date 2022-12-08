#!/bin/bash

#define parameters
success="✅"
error="❌"
warning="⚠️"
tips="💡"
info="⇢"

printf "\n"
echo "$info|・・・・ Updating the OS enviroments ・・・・[ $tips ] "
sudo apt update && apt upgrade -y

sleep 5
wait $!
printf "\n"
echo "$info|・・・・ Installing liblwloc-dev and pkc-config ・・・・[ $tips ] "
sudo apt install -y libhwloc-dev
sudo apt install -y pkg-config

sleep 2
wait $!
printf "\n"
echo "$info|・・・・ Installing libIOpenCL ・・・・[ $tips ]"
sudo ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/libOpenCL.so

if cat ~/.bashrc | grep 'export LD_LIBRARY_PATH'; then
    echo "$info|・・・・ LD_LIBRARAY_PATH has exists!・・・・[ $warning ]"
else
    echo "export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/" >>"$HOME"/.bashrc
fi
printf "\n"
echo "$info|・・・・ Installing golang package ・・・・[ $tips ] "
if cat ~/.bashrc | grep '/usr/local/go/bin'; then
    echo "$info|・・・・ Golang has exists!・・・・[ $warning ]"
else
    wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
    sleep 3
    wait $!
    sudo rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
    echo "export PATH=$PATH:/usr/local/go/bin" >>"$HOME"/.bashrc
    sudo ldconfig

    echo "$info|・・・・ Golang package finished! and remove golang package・・・・[ $success ]"
    sudo rm -f go1.19.3.linux-amd64.tar.gz
fi

source ~/.bashrc
printf "\n"
echo "$info|・・・・ Begin to git submodule update ・・・・[ $tips ]"
git submodule update --init --recursive

sleep 10
wait $!

make ffi && make

sleep 10
wait $!
CUR_DIR=$(pwd)

echo "$info|・・・・ Set up the graphsplit env to bashrc ・・・・[ $tips ]"
echo "export graphsplit='$CUR_DIR/graphsplit'" >>"$HOME"/.bashrc
echo "$info|・・・・ Reload bashrc file ・・・・[ $tips ]"
source ~/.bashrc

echo "$info|・・・・ All the packages has finished and Enviroment was setup!・・・・[ $success ]"
