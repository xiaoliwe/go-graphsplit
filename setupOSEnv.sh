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
