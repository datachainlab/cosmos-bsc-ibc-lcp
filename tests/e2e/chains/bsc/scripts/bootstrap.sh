#!/usr/bin/env bash
set -eu

workspace=$(
	cd $(dirname $0)
	pwd
)/..

function prepare() {
	if ! [[ -f /usr/local/bin/geth ]]; then
		echo "geth do not exist!"
		exit 1
	fi
	# run `make clean` to remove files
	cd ${workspace}/genesis
	rm -rf validators.conf
}

function init_validator() {
	node_id=$1
	geth --datadir ${workspace}/storage/${node_id} account new --password /dev/null >${workspace}/storage/${node_id}Info
	validatorAddr=$(cat ${workspace}/storage/${node_id}Info | grep 'Public address of the key' | awk '{print $6}')
    echo "123456" > ${workspace}/storage/${node_id}/blspassword.txt
    expect ${workspace}/scripts/create_bls_key.sh ${workspace}/storage/${node_id}
    voteAddr=0x$(cat ${workspace}/storage/${node_id}/bls/keystore/*json| jq .pubkey | sed 's/"//g')

    echo "${validatorAddr},${validatorAddr},${validatorAddr},0x0000000010000000,${voteAddr}" >>scripts/validators.conf
	echo ${validatorAddr} >${workspace}/storage/${node_id}/address
}

function generate_genesis() {
	INIT_HOLDER_ADDRESSES=$(ls ${workspace}/init-holders | tr '\n' ',')
	INIT_HOLDER_ADDRESSES=${INIT_HOLDER_ADDRESSES/%,/}
	echo "blocks per epoch = ${BLOCKS_PER_EPOCH}"
  sed "s/{{BLOCKS_PER_EPOCH}}/${BLOCKS_PER_EPOCH}/g" genesis-template.template >genesis-template.json
  sed "s/{{INIT_HOLDER_ADDRESSES}}/${INIT_HOLDER_ADDRESSES}/g" scripts/init_holders.template | sed "s/{{INIT_HOLDER_BALANCE}}/${INIT_HOLDER_BALANCE}/g" >scripts/init_holders.js

  sed "s/INIT_NUM_OF_CABINETS = 21/INIT_NUM_OF_CABINETS = ${INIT_NUM_OF_CABINETS}/g" contracts/BSCValidatorSet.sol >contracts/BSCValidatorSet.sol.out
  mv contracts/BSCValidatorSet.sol.out contracts/BSCValidatorSet.sol
  sed "s/dev_chain_id: int = 714/dev_chain_id: int = ${BSC_CHAIN_ID}/g" scripts/generate.py > scripts/generate.py.out
  sed "s/epoch: str = \"200\"/epoch: str = \"${BLOCKS_PER_EPOCH}\"/g" scripts/generate.py.out > scripts/generate.py

	node scripts/generate-validator.js
	/root/.local/bin/poetry run python3 scripts/generate.py dev
}

function init_genesis_data() {
	node_type=$1
	node_id=$2
	geth --datadir ${workspace}/storage/${node_id} init --state.scheme hash --db.engine=leveldb ${workspace}/genesis/genesis.json
	cp ${workspace}/config/config-${node_type}.toml ${workspace}/storage/${node_id}/config.toml
	sed -i -e "s/{{NetworkId}}/${BSC_CHAIN_ID}/g" ${workspace}/storage/${node_id}/config.toml
	if [ "${node_id}" == "bsc-rpc" ]; then
		cp ${workspace}/init-holders/* ${workspace}/storage/${node_id}/keystore
		cp ${workspace}/genesis/genesis.json ${workspace}/storage/${node_id}
		cp ${workspace}/config/bootstrap.key ${workspace}/storage/${node_id}/geth/nodekey
	fi
}

prepare

# First, generate config for each validator
for ((i = 1; i <= ${NUMS_OF_VALIDATOR}; i++)); do
	init_validator "bsc-validator${i}"
done

# Then, use validator configs to generate genesis file
generate_genesis

# Finally, use genesis file to init cluster data
init_genesis_data bsc-rpc bsc-rpc

for ((i = 1; i <= ${NUMS_OF_VALIDATOR}; i++)); do
	init_genesis_data validator "bsc-validator${i}"
done

echo "##############genesis.json(exclude alloc prop)##############"
jq 'del(.alloc)' < ${workspace}/genesis/genesis.json

echo "##############config.toml##############"
cat ${workspace}/storage/${node_id}/config.toml
