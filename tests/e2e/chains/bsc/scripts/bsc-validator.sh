source /scripts/utils.sh

DATA_DIR=/root/.ethereum

wait_for_host_port ${BOOTSTRAP_HOST} ${BOOTSTRAP_TCP_PORT}
BOOTSTRAP_IP=$(get_host_ip $BOOTSTRAP_HOST)
VALIDATOR_ADDR=$(cat ${DATA_DIR}/address)
HOST_IP=$(hostname -i)

echo "validator id: ${HOST_IP}"

ETHSTATS=""
if [ $ENABLED_ETHSTATS = "true" ]; then
	ETHSTATS="--ethstats ${NODE_ID}:${NETSTATS_URL}"
fi
geth --config ${DATA_DIR}/config.toml --datadir ${DATA_DIR} --netrestrict ${CLUSTER_CIDR} \
  --state.scheme=hash \
  --db.engine=leveldb \
  --gcmode archive \
	--verbosity ${VERBOSE} ${ETHSTATS} \
	--bootnodes enode://${BOOTSTRAP_PUB_KEY}@${BOOTSTRAP_IP}:${BOOTSTRAP_TCP_PORT} \
	--mine \
	--miner.etherbase=${VALIDATOR_ADDR} \
	--unlock ${VALIDATOR_ADDR} \
	--password /dev/null \
	--blspassword /scripts/wallet_password.txt \
	--light.serve 50 --pprof.addr 0.0.0.0 --metrics \
	--rpc.allow-unprotected-txs --history.transactions 15768000 \
	--pprof --ipcdisable --vote --override.fixedturnlength 2
