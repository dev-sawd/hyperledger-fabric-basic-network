#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.

rm -rf ./config
mkdir config
rm -rf crypto-config

export PATH=./bin:$PATH
cryptogen generate --config=./crypto-config.yaml

configtxgen -profile OneOrgOrdererGenesis -outputBlock ./config/genesis.block

configtxgen -profile OneOrgChannel -outputCreateChannelTx ./config/channel.tx -channelID mychannel

configtxgen -profile OneOrgChannel -outputAnchorPeersUpdate ./config/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP

export SK_NAME=$(cd crypto-config/peerOrganizations/org1.example.com/ca && ls *_sk)
SK_NAME=$SK_NAME docker-compose -f docker-compose.yml up -d ca.example.com orderer.example.com peer0.org1.example.com couchdb cli peer1.org1.example.com orderer2.example.com orderer3.example.com

docker exec cli ./scripts/script.sh mychannel 3 golang
