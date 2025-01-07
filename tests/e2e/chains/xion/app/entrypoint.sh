#!/bin/sh
set -x

if [ -z "$IBC_AUTHORITY" ]
then
    export IBC_AUTHORITY=`jq -r .address ${CHAINDIR}/${CHAINID}/key_seed.json`
else
    unset IBC_AUTHORITY
fi

xiond --home ${CHAINDIR}/${CHAINID} start --pruning=nothing
