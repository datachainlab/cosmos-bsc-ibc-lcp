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

## How to build

### Software Mode

#### Pre-requisites

The following components should be installed in the environment.

* Intel SGX SDK  
  Install according to [manual](https://https://github.com/intel/linux-sgx/tree/sgx_2.19) or use provided packages.
  ```sh
  curl -LO https://download.01.org/intel-sgx/sgx-linux/2.19/distro/ubuntu22.04-server/sgx_linux_x64_sdk_2.19.100.3.bin
  chmod +x sgx_linux_x64_sdk_2.19.100.3.bin
  echo -e 'no\n/opt' | ./sgx_linux_x64_sdk_2.19.100.3.bin
  ```
* LCP
  ```sh
  git clone https://github.com/datachainlab/lcp.git -b v0.2.9
  cd lcp
  export SGX_MODE=SW 
  source /opt/sgxsdk/environment && make -B
  cp ./bin/lcp /usr/local/bin/
  ```

#### Build enclave and run E2E test

```
$ export SGX_MODE=SW
$ source /opt/sgxsdk/environment
$ make all yrly build-images prepare-contracts 
$ make e2e-test
$ make down
```

## Hardware Mode

* Intel SGX SDK  
* Intel SGX PSW
* LCP
  ```sh
  git clone https://github.com/datachainlab/lcp.git -b v0.2.9
  cd lcp
  source /opt/sgxsdk/environment && make -B
  cp ./bin/lcp /usr/local/bin/
  ```

#### Build enclave and run E2E test

```
$ source /opt/sgxsdk/environment
$ make all yrly build-images prepare-contracts 
$ make e2e-test
$ make down
```

NOTE: if you run into the following error, you need to set `LD_LIBRARY_PATH` environment variable that include `libsgx_urts.so`.
```
lcp: error while loading shared libraries: libsgx_urts.so: cannot open shared object file: No such file or directory
```
```sh
$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/sgxsdk/lib64
```