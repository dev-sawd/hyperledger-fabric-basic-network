## Basic Network Config

This project is for golang chaincode development.

Fabric version : 2.4.2

### docker list
- ca_org1
- ca_orderer
- peer0.org1.example.com
- couchdb0
- orderer.example.com
- cli

### Ordering service
- solo(default)

To start the basic network run ``start.sh``.

clear docker container and chaincode ``teardown.sh``.

### Install your chaincode for testing
sh ./network.sh deployCC -ccn [CHAINCODE_NAME] -ccv [CHIANCODE_VERSION] -cci initLedger -ccl "go" -ccp [CHAINCODE_PATH]

ex)
`sh ./network.sh deployCC -ccn fabcar -ccv 1 -ccl "go" -ccp ./chaicnde/go/fabcar

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>
