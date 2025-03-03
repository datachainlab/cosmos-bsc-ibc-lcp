package main

import (
	"fmt"
	"os"

	cw "github.com/datachainlab/cosmwasm-ibc-relay-prover/relay"
	cwtm "github.com/datachainlab/cosmwasm-ibc-relay-prover/relay/tendermint"
	"github.com/datachainlab/ethereum-ibc-relay-chain/pkg/relay/ethereum"
	"github.com/datachainlab/ibc-hd-signer/pkg/hd"
	parlia "github.com/datachainlab/ibc-parlia-relay/module"
	lcp "github.com/datachainlab/lcp-go/relay"
	rawsigner "github.com/datachainlab/lcp-go/relay/signers/raw"
	lcptm "github.com/datachainlab/lcp-go/relay/tendermint"
	tendermint "github.com/hyperledger-labs/yui-relayer/chains/tendermint/module"
	"github.com/hyperledger-labs/yui-relayer/cmd"
)

func main() {
	if err := cmd.Execute(
		tendermint.Module{},
		ethereum.Module{},
		parlia.Module{},
		hd.Module{},
		lcp.Module{},
		lcptm.Module{},
		cw.Module{},
		cwtm.Module{},
		rawsigner.Module{},
	); err != nil {
		fmt.Fprintln(os.Stderr, "Error:", err)
		os.Exit(1)
	}
}
