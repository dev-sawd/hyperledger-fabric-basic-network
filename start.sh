#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error
set -e

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1
starttime=$(date +%s)
CC_SRC_LANGUAGE=${1:-"go"}
CC_SRC_LANGUAGE=`echo "$CC_SRC_LANGUAGE" | tr [:upper:] [:lower:]`
CC_SRC_PATH="./chaincode/fabcar/go/"


# clean out any old identites in the wallets
rm -rf go/wallet/*

# launch network; create channel and join peer to channel
sh ./network.sh down
sh ./network.sh up createChannel -ca -s couchdb

# install fabcar chaincode
sh ./network.sh deployCC -ccn fabcar -ccv 1 -cci initLedger -ccl ${CC_SRC_LANGUAGE} -ccp ${CC_SRC_PATH}

cat <<EOF

Total setup execution time : $(($(date +%s) - starttime)) secs ...

Next, use the FabCar applications to interact with the deployed FabCar contract.
The FabCar applications are available in multiple programming languages.
Follow the instructions for the programming language of your choice:

Go:

  Start by changing into the "go" directory:
    cd ./chaincode/fabcar/go

  Then, install dependencies and run the test using:
    go run fabcar.go

  The test will invoke the sample client app which perform the following:
    - Import user credentials into the wallet (if they don't already exist there)
    - Submit a transaction to create a new car
    - Evaluate a transaction (query) to return details of this car
    - Submit a transaction to change the owner of this car
    - Evaluate a transaction (query) to return the updated details of this car

EOF
