# cosmos-bsc-ibc-lcp

## Pre-requisites
* [Intel SGX SDK 2.19](https://github.com/intel/linux-sgx/tree/sgx_2.19/sdk)
- [lcp v0.2.9](https://github.com/datachainlab/lcp/releases/tag/v0.2.9)

### Quick installation
```sh
curl -LO https://download.01.org/intel-sgx/sgx-linux/2.19/distro/ubuntu22.04-server/sgx_linux_x64_sdk_2.19.100.3.bin
chmod +x sgx_linux_x64_sdk_2.19.100.3.bin
echo -e 'no\n/opt' | ./sgx_linux_x64_sdk_2.19.100.3.bin

git clone https://github.com/datachainlab/lcp.git -b v0.2.9
cd lcp
source /opt/sgxsdk/environment && make -B
cp ./bin/lcp /usr/local/bin/
```

## Build enclave and run E2E test

### SGX HW mode(default)

```
$ make all yrly build-images prepare-contracts 
$ make e2e-test
```

### SGX SW mode

```
$ export SGX_MODE=SW
$ make all yrly build-images prepare-contracts 
$ make e2e-test
```