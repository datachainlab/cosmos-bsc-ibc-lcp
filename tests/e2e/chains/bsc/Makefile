include ../../env.mk

SHELL:=/usr/bin/env sh

DOCKER ?= docker

GIT_SOURCE=https://github.com/binance-chain/bsc.git
GIT_CHECKOUT_BRANCH=v1.4.13 #bsc ノードのバージョン

OSFLAG :=

# Build & start simple validator cluster
.PHONY:docker-build
docker-build:
	make docker-build-bsc
	make docker-build-bsc-bootstrap

.PHONY:docker-build-bsc
docker-build-bsc:
	$(DOCKER) build -t toki-bsc-geth:$(GIT_CHECKOUT_BRANCH) --target bsc_geth \
	--build-arg GIT_SOURCE=$(GIT_SOURCE) --build-arg GIT_CHECKOUT_BRANCH=$(GIT_CHECKOUT_BRANCH) $(EXTRA_VARS) .

.PHONY:docker-build-bsc-bootstrap
docker-build-bsc-bootstrap:
	$(DOCKER) build -t toki-bsc-geth-bootstrap:$(GIT_CHECKOUT_BRANCH) --target bsc_geth_bootstrap \
	--build-arg GIT_SOURCE=$(GIT_SOURCE) --build-arg GIT_CHECKOUT_BRANCH=$(GIT_CHECKOUT_BRANCH) $(EXTRA_VARS) .

# run only bootstrap
.PHONY:bootstrap
bootstrap:
	GIT_CHECKOUT_BRANCH=$(GIT_CHECKOUT_BRANCH) $(OSFLAG) \
	$(OSFLAG) docker compose -f docker-compose.simple.yml run --rm toki-bsc-bootstrap-simple

# run bsc-rpc, bsc-validator1
.PHONY:network
network:
	GIT_CHECKOUT_BRANCH=$(GIT_CHECKOUT_BRANCH) $(OSFLAG) \
	$(OSFLAG) docker compose -f docker-compose.simple.yml up -d --wait \
	toki-bsc-rpc toki-bsc-validator1 toki-bsc-validator2 toki-bsc-validator3 toki-bsc-validator4

.PHONY:network-down
network-down:
	GIT_CHECKOUT_BRANCH=$(GIT_CHECKOUT_BRANCH) $(OSFLAG) \
	$(OSFLAG) docker compose -f docker-compose.simple.yml down -v

# run bootstrap and bsc-rpc, bsc-validator1
.PHONY:network-all
network-all:
	GIT_CHECKOUT_BRANCH=$(GIT_CHECKOUT_BRANCH) $(OSFLAG) \
	$(OSFLAG) docker compose -f docker-compose.simple.yml -f docker-compose.simple.override.yml up -d

.PHONY:reset-network
reset-network: network-down network-all
#reset-network: network-down bootstrap network

#------------------------------------------------------------------------------
# Util
#------------------------------------------------------------------------------
.PHONY:shfmt
shfmt:
	shfmt -l -w ./scripts/*.sh

.PHONY:shchk
shchk:
	shellcheck ./scripts/*.sh

VARS = GIT_SOURCE GIT_CHECKOUT_BRANCH

$(VARS):
	@echo $($@)
