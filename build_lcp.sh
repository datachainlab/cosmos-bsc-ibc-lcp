#!/bin/bash

git clone https://github.com/datachainlab/lcp.git -b v0.2.9
cd lcp
make -B
sudo cp ./bin/lcp /usr/local/bin/