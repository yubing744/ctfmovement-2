#!/bin/bash

source ./scripts/00.config.sh
aptos move run --url http://8.218.146.10:9080 --assume-yes --function-id ${MY_ADDRESS}::solution2::init
