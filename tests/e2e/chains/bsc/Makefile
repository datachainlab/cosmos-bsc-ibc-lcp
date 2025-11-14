DOCKER_COMPOSE ?= docker compose
HARDHAT ?= npx hardhat

.PHONY:build
build:
	$(DOCKER_COMPOSE) -f docker-compose.bsc.yml build
	$(DOCKER_COMPOSE) build

.PHONY:bootstrap
bootstrap:
	$(DOCKER_COMPOSE) run --rm bootstrap

.PHONY:network
network:
	$(DOCKER_COMPOSE) up -d bsc-rpc
	sleep 5
	$(DOCKER_COMPOSE) up -d bsc-validator1-1
	sleep 5
	$(DOCKER_COMPOSE) up -d bsc-validator1-2
	sleep 5
	$(DOCKER_COMPOSE) up -d bsc-validator1-3

.PHONY:network-down
network-down:
	$(DOCKER_COMPOSE) down -v

#------------------------------------------------------------------------------
# Contract Deployment
#------------------------------------------------------------------------------
.PHONY:deploy
deploy: dep
	$(DOCKER_COMPOSE) run --rm -e USE_UPGRADE_TEST=$(USE_UPGRADE_TEST) -e LCP_ENCLAVE_DEBUG=$(LCP_ENCLAVE_DEBUG) -e NO_RUN_LCP=$(NO_RUN_LCP) -e ZKDCAP=$(ZKDCAP) -e LCP_ZKDCAP_RISC0_MOCK=$(LCP_ZKDCAP_RISC0_MOCK) contracts $(HARDHAT) run ./scripts/deploy.js --network eth_local

.PHONY: dep
dep:
	$(DOCKER_COMPOSE) run --rm contracts npm install

.PHONY: clean
clean:
	$(DOCKER_COMPOSE) run contracts sh -c '$(HARDHAT) clean && rm -rf node_modules && rm -f package-lock.json'

.PHONY: rm-oz-upgrades
rm-oz-upgrades:
	$(DOCKER_COMPOSE) run contracts sh -c 'rm -rf .openzeppelin'

.PHONY: extract-abi
extract-abi:
	./scripts/extract-abi.sh
