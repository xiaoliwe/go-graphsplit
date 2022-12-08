#!/bin/bash

#define parameters
success="✅"
error="❌"
warning="⚠️"
tips="💡"
leftinfo="⇠"
info="⇢"

printf "\n"
echo "$info|・・・・ Updating the OS enviroments ・・・・| $leftinfo  "
sudo apt update && apt upgrade -y

sleep 5
wait $!
printf "\n"
echo "$info|・・・・ Installing liblwloc-dev and pkc-config ・・・・| $leftinfo "
sudo apt install -y libhwloc-dev
sudo apt install -y pkg-config

sleep 2
wait $!
printf "\n"
echo "$info|・・・・ Installing libIOpenCL ・・・・| $leftinfo "
sudo ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/libOpenCL.so

if cat ~/.bashrc | grep 'export LD_LIBRARY_PATH'; then
    echo "$info|・・・・ LD_LIBRARAY_PATH has exists!・・・・[ $warning ]"
else
    echo "export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/" >>"$HOME"/.bashrc
fi
printf "\n"
echo "$info|・・・・ Installing golang package ・・・・| $leftinfo  "
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
echo "$info|・・・・ Begin to git submodule update ・・・・| $leftinfo "
git submodule update --init --recursive

sleep 10
wait $!

make ffi && make

sleep 10
wait $!
CUR_DIR=$(pwd)

echo "$info|・・・・ Set up the graphsplit env to bashrc ・・・・| $leftinfo "
if cat ~/.bashrc | grep 'export graphsplit'; then
    echo "$info|・・・・ Reload bashrc file ・・・・[ $warning ]"
else
    echo "export PATH=$PATH:$CUR_DIR/graphsplit" >>/etc/environment
    echo "$info|・・・・ Reload bashrc file ・・・・| $leftinfo "
    source /etc/environment
fi

echo "$info|・・・・ All the packages has finished and Enviroment was setup!・・・・[ $success ]"
