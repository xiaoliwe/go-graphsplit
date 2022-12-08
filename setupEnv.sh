#!/bin/bash

#define parameters
success="✅"
error="❌"
warning="⚠️"
tips="💡"
info="⇢"
spot="・・・・"

printf "\n"
echo "$info|$spot Updating the OS enviroments ${spot[$tips]} "
sudo apt update && apt upgrade -y

sleep 5
wait $!
printf "\n"
echo "$info|$spot Installing liblwloc-dev and pkc-config ${spot[$tips]} "
sudo apt install -y libhwloc-dev
sudo apt install -y pkg-config

sleep 2
wait $!
printf "\n"
echo "$info|$spot Installing libIOpenCL ${spot[$tips]} "
sudo ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/libOpenCL.so

if cat ~/.bashrc | grep 'export LD_LIBRARY_PATH'; then
    echo "$info|$spot LD_LIBRARAY_PATH has exists!${spot[$warning]}"
else
    echo "export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/" >>"$HOME"/.bashrc
fi
printf "\n"
echo "$info|$spot Installing golang package ${spot[$tips]} "
if cat ~/.bashrc | grep '/usr/local/go/bin'; then
    echo "$info|$spot Golang has exists!${spot[$warning]}"
else
    wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
    sleep 3
    wait $!
    sudo rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
    echo "export PATH=$PATH:/usr/local/go/bin" >>"$HOME"/.bashrc
    sudo ldconfig

    echo "$info|$spot Golang package finished! and remove golang package ${spot[$success]}"
    sudo rm -f go1.19.3.linux-amd64.tar.gz
fi

source ~/.bashrc
printf "\n"
echo "$info|$spot Begin to git submodule update ${spot[$tips]}"
git submodule update --init --recursive

sleep 10
wait $!

make ffi && make

sleep 10
wait $!
CUR_DIR=$(pwd)

echo "$info|$spot Set up the graphsplit env to bashrc ${spot[$tips]}"
echo "export graphsplit='$CUR_DIR/graphsplit'" >>"$HOME"/.bashrc
echo "$info|$spot Reload bashrc file ${spot[$tips]}"
source ~/.bashrc

echo "$info|$spot All the packages has finished and Enviroment was setup!${spot[$success]}"
