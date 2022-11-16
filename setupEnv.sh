#!/bin/bash

#install liblwloc-dev
sudo apt install libhwloc-dev

#install libIOpenCL
sudo ln -s /usr/lib/x86_64-linux-gnu/libOpenCL.so.1 /usr/lib/libOpenCL.so
echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/"' >> ~/.bashrc
sudo ldconfig

#Setup the ~/.bashrc and user's env
alias apt-up='apt update && apt upgrade'

#build repos
git submodule update --init --recursive
make ffi && make


