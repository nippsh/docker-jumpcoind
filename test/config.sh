#!/bin/bash
set -e

testAlias+=(
	[jumpcoind:trusty]='jumpcoind'
)

imageTests+=(
	[jumpcoind]='
		rpcpassword
	'
)
