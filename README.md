# cosmos-bsc-ibc-lcp

This is a cross-chain messaging demo between Cosmos and BSC using IBC and LCP (Light Client Proxy).

This project is related to the [cosmos-ethereum-ibc-lcp](https://github.com/datachainlab/cosmos-ethereum-ibc-lcp).

## Supported Versions
- [ibc-solidity v0.3.29](https://github.com/hyperledger-labs/yui-ibc-solidity/releases/tag/v0.3.29)
- [lcp v0.2.9](https://github.com/datachainlab/lcp/releases/tag/v0.2.9)
- [parlia-elc v0.3.1](https://github.com/datachainlab/parlia-elc/releases/tag/v0.3.1)
- [lcp-go v0.2.10](https://github.com/datachainlab/lcp-go/releases/tag/v0.2.10)
- [lcp-solidity v0.1.14](https://github.com/datachainlab/lcp-solidity/releases/tag/v0.1.14)
- [yui-relayer v0.5.4](https://github.com/hyperledger-labs/yui-relayer/releases/tag/v0.5.4)
- [ethereum-ibc-relay-chain v0.3.4](https://github.com/datachainlab/ethereum-ibc-relay-chain/releases/tag/v0.3.4)
- [ibc-parlia-relay v0.3.2](https://github.com/datachainlab/ibc-parlia-relay/releases/tag/v0.3.2)

## Pre-requisites

The following components should be installed in the environment.

* Intel SGX SDK  
  Install according to the [manual](https://https://github.com/intel/linux-sgx).
* LCP
  ```sh
  git clone https://github.com/datachainlab/lcp.git -b v0.2.9
  cd lcp
  export SGX_MODE=SW 
  source /opt/sgxsdk/environment && make -B
  cp ./bin/lcp /usr/local/bin/
  ```

### Build enclave and run E2E test

```
$ export SGX_MODE=SW
$ source /opt/sgxsdk/environment
$ make all yrly build-images prepare-contracts 
$ make e2e-test
$ make down
```
```