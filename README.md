# cosmos-bsc-ibc-lcp

## Pre-requisites
* [Intel SGX SDK 2.19 or above]()
* [LCP 0.2.29]()

### Quick installation
```sh
curl -LO https://download.01.org/intel-sgx/sgx-linux/2.19/distro/ubuntu22.04-server/sgx_linux_x64_sdk_2.19.100.3.bin
chmod +x sgx_linux_x64_sdk_2.19.100.3.bin
echo -e 'no\n/opt' | ./sgx_linux_x64_sdk_2.19.100.3.bin
source /opt/sgxsdk/environment && make -B
```
