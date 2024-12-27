# cosmos-bsc-ibc-lcp

This is a cross-chain messaging demo between Cosmos and BSC using IBC and LCP (Light Client Proxy).

## Supported Versions
- [ibc-solidity v0.3.40](https://github.com/hyperledger-labs/yui-ibc-solidity/releases/tag/v0.3.40)
- [lcp v0.2.12](https://github.com/datachainlab/lcp/releases/tag/v0.2.12)
- [lcp-go v0.2.13](https://github.com/datachainlab/lcp-go/releases/tag/v0.2.13)
- [lcp-solidity v0.1.17](https://github.com/datachainlab/lcp-solidity/releases/tag/v0.1.17)
- [yui-relayer v0.5.10](https://github.com/hyperledger-labs/yui-relayer/releases/tag/v0.5.10)
- [ethereum-ibc-relay-chain v0.3.13](https://github.com/datachainlab/ethereum-ibc-relay-chain/releases/tag/v0.3.13)
- [parlia-elc v0.3.7](https://github.com/datachainlab/parlia-elc/releases/tag/v0.3.7)
- [ibc-parlia-relay v0.3.8](https://github.com/datachainlab/ibc-parlia-relay/releases/tag/v0.3.8)

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
