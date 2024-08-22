### Genesis json
A scripts/genesis-template.template is a template derived with [bnb-chain/bsc-genesis-contract](https://github.com/bnb-chain/bsc-genesis-contract/blob/v1.1.8/genesis-template.json).
It also makes `BLOCKS_PER_EPOCH` changeable.

The initial users shown below, listed as init-holders, were prepared at bootstrap.

|Address|Description|
|:--|:--|
|0xa89F47C6b463f74d87572b058427dA0A13ec5425| The address of the Relayer and the Deployer.|
|0xcBED645B1C1a6254f1149Df51d3591c6B3803007| A user as Alice for E2E testing.|
|0x00731540cd6060991D6B9C57CE295998d9bC2faB| A user as Bob for E2E testing.|
|0xf885ef252e94def5c54746218704e0122c53bdf5| A reserved address for testing. (Not currently used)|
|0x55797d2257292f97736a2610f2f182a9b61432d6| A reserved address for testing. (Not currently used)|

### Tuning a chain config
#### BLOCKS_PER_EPOCH
1. Change an environment variable of BLOCKS_PER_EPOCH in the [docker-compose.simple.yml](./docker-compose.simple.yml). The default value is 200.
2. Change an argument of BLOCKS_PER_EPOCH in the [lcp/Dockerfile](../../../lcp/Dockerfile)
3. Enable the dev tag in the [relayer/Dockerfile](../../../relayer/Dockerfile).
