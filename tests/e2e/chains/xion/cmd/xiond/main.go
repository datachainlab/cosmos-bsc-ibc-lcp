package main

import (
	"os"

	"cosmossdk.io/log"

	svrcmd "github.com/cosmos/cosmos-sdk/server/cmd"

	"github.com/datachainlab/cosmos-ethereum-ibc-lcp/tests/e2e/chains/xion/app"
	"github.com/datachainlab/lcp-go/sgx/ias"
)

func main() {
	rootCmd, _ := NewRootCmd()

	// WARNING: if you use the simd in production, you must remove the following code:
	ias.SetAllowDebugEnclaves()
	defer ias.UnsetAllowDebugEnclaves()
	// END WARNING

	if err := svrcmd.Execute(rootCmd, "", app.DefaultNodeHome); err != nil {
		log.NewLogger(rootCmd.OutOrStderr()).Error("failure when running app", "err", err)
		os.Exit(1)
	}
}
