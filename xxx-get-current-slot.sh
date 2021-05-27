  curl -s https://graphql-api.testnet.dandelion.link \
    -H 'Content-Type: application/json' -H 'Accept: application/json' \
    --data-binary '{ "query": "{ cardano { tip { slotNo } } }" }' | jq .data.cardano.tip.slotNo