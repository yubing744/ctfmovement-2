#!/bin/bash

source ./scripts/00.config.sh
aptos move publish --url http://8.218.146.10:9080 --assume-yes --package-dir . --named-addresses ctfmovement=${CTF_CONTRACT},solution=${MY_ADDRESS}