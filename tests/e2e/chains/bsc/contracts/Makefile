.PHONY:deploy
deploy: dep
	USE_UPGRADE_TEST=$(USE_UPGRADE_TEST) LCP_ENCLAVE_DEBUG=$(LCP_ENCLAVE_DEBUG) NO_RUN_LCP=$(NO_RUN_LCP) ZKDCAP=$(ZKDCAP) LCP_ZKDCAP_RISC0_MOCK=$(LCP_ZKDCAP_RISC0_MOCK) npx hardhat run ./scripts/deploy.js --network eth_local

.PHONY: dep
dep:
	npm install

.PHONY: clean
clean:
	npx hardhat clean && rm -rf node_modules && rm -f package-lock.json

.PHONY: rm-oz-upgrades
rm-oz-upgrades:
	sh -c 'rm -rf .openzeppelin'

