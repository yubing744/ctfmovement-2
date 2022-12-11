#!/bin/bash

source ./scripts/00.config.sh
aptos move compile --package-dir . --named-addresses ctfmovement=${CTF_CONTRACT},solution=${MY_ADDRESS}