#!/bin/bash

source ./scripts/00.config.sh

function check_result() {
  local transaction_hash=$1
  events=$(curl http://8.218.146.10:9080/v1/transactions/by_hash/${transaction_hash} --compressed | jq -r .Result.events)
  echo events: ${events}
}

echo "1. Getting flag"
getFlagResult=$(aptos move run --url http://8.218.146.10:9080 --assume-yes --function-id ${MY_ADDRESS}::solution2::get_flag)
echo getFlagResult: ${getFlagResult}
transaction_hash=$(echo ${getFlagResult} | jq -r .Result.transaction_hash)
echo transaction_hash: ${transaction_hash}

echo "2. Checking result"
check_result ${transaction_hash}