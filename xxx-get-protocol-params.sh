NETWORK=$1

  cat >./wallet/query<<EOF
{ "query": "{ genesis { shelley { protocolParams { a0 decentralisationParam eMax extraEntropy keyDeposit maxBlockBodySize maxBlockHeaderSize maxTxSize minFeeA minFeeB minPoolCost minUTxOValue nOpt poolDeposit protocolVersion rho tau }  }  } }" }
EOF

  curl -s https://graphql-api.${NETWORK}.dandelion.link \
    -H 'Content-Type: application/json' -H 'Accept: application/json' \
    --data-binary @./wallet/query | jq .data.genesis.shelley.protocolParams > ./wallet/protocol-parameters.json
