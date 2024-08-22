#!/usr/bin/env bash

set -eux

berlinBlock=$(jq -r '.config.berlinBlock' < /root/.ethereum/genesis.json)
currentBlock=$(geth attach --exec "eth.blockNumber" /root/.ethereum/geth.ipc)

test $currentBlock -ge $berlinBlock
