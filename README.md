# cosmos-bsc-ibc-lcp

This is a cross-chain messaging demo between Cosmos and BSC using IBC and LCP (Light Client Proxy).

## Supported Versions
- [ibc-solidity v0.3.38](https://github.com/hyperledger-labs/yui-ibc-solidity/releases/tag/v0.3.38)
- [lcp v0.2.11](https://github.com/datachainlab/lcp/releases/tag/v0.2.11)
- [lcp-go v0.2.10](https://github.com/datachainlab/lcp-go/releases/tag/v0.2.10)
- [lcp-solidity v0.1.15](https://github.com/datachainlab/lcp-solidity/releases/tag/v0.1.15)
- [yui-relayer v0.5.8](https://github.com/hyperledger-labs/yui-relayer/releases/tag/v0.5.8)
- [ethereum-ibc-relay-chain v0.3.10](https://github.com/datachainlab/ethereum-ibc-relay-chain/releases/tag/v0.3.10)
- [parlia-elc v0.3.2](https://github.com/datachainlab/parlia-elc/releases/tag/v0.3.2)
- [ibc-parlia-relay v0.3.4](https://github.com/datachainlab/ibc-parlia-relay/releases/tag/v0.3.4)

## Pre-requisites

[Intel SGX SDK and PSW](https://github.com/intel/linux-sgx) should be installed in the environment.
 * PSW is optional in SW mode. 

## Build enclave and run E2E test

### SGX HW mode(default)
```
$ make build-images prepare-contracts 
$ make e2e-test
$ make down
```

### SGX SW mode

```
$ export SGX_MODE=SW
$ source /opt/sgxsdk/environment
$ make build-images prepare-contracts 
$ make e2e-test
$ make down
```

## Related Projects
 - [cosmos-ethereum-ibc-lcp](https://github.com/datachainlab/cosmos-ethereum-ibc-lcp).
