#!/usr/bin/env bash

source /scripts/utils.sh

DATA_DIR=/root/.ethereum

account_cnt=$(ls ${DATA_DIR}/keystore | wc -l)
i=1
unlock_sequences="0"
while [ "$i" -lt ${account_cnt} ]; do
	unlock_sequences="${unlock_sequences},${i}"
	i=$((i + 1))
done

ETHSTATS=""
if [ $ENABLED_ETHSTATS = "true" ]; then
	ETHSTATS="--ethstats ${NODE_ID}:${NETSTATS_URL}"
fi
geth --config ${DATA_DIR}/config.toml --datadir ${DATA_DIR} --netrestrict ${CLUSTER_CIDR} \
  --state.scheme=hash \
  --db.engine=leveldb \
	--gcmode archive \
	--verbosity ${VERBOSE} --nousb ${ETHSTATS} \
	--log.debug \
	--log.vmodule=rpc/*=5 \
	--unlock ${unlock_sequences} \
	--password /dev/null \
	--http.corsdomain=* --override.fixedturnlength 2
