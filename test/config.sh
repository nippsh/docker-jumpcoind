#!/bin/bash
set -e

testAlias+=(
	[jumpcoind:trusty]='bitcoind'
)

imageTests+=(
	[jumpcoind]='
		rpcpassword
	'
)
