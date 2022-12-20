#!/bin/bash

#define parameters
success="✅"
error="❌"
warning="⚠️"
tips="💡"
leftinfo="⇠"
info="⇢"

printf "\n"
echo "$info|・・・・ Installing golang package ・・・・| $leftinfo  "
if which go; then
    echo "$info|・・・・ Golang has exists!・・・・[ $warning ]"
else
    CUR_DIR=$(pwd)
    if [ ! -f "$CUR_DIR/go1.19.3.linux-amd64.tar.gz" ]; then
        wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
        sleep 3
        wait $!
    fi
    tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
    echo "export PATH=$PATH:/usr/local/go/bin" >>"$HOME"/.bashrc

    echo "$info|・・・・ Golang package finished! and remove golang package・・・・[ $success ]"

fi

printf "\n"
echo "$info|・・・・ Installing Rust package ・・・・| $leftinfo  "
if [ ! -f "$HOME/.cargo/bin/rustup" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
else
    echo "$info|・・・・ Rustup has exists!・・・・[ $warning ]"
fi

source "$HOME/.bashrc"
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
    echo "export graphsplit='$CUR_DIR'" >>"$HOME"/.bashrc
    echo "$info|・・・・ Reload bashrc file ・・・・| $leftinfo "
    source "$HOME/.bashrc"
fi

echo "$info|・・・・ All the packages has finished and Enviroment was setup!・・・・[ $success ]"
