ADDRESS=$1

  cat >./wallet/query<<EOF
{ "query" : "{ utxos( order_by: { value: desc } where: { address: { _eq: \"${ADDRESS}\" }} ) { address index txHash value tokens { quantity asset { policyId assetId assetName } } } }" }
EOF

curl -s https://graphql-api.testnet.dandelion.link \
  -H 'Content-Type: application/json' -H 'Accept: application/json' \
  --data-binary @./wallet/query | jq .data.utxos > ./wallet/utxos.json

IN_UTXO=$(jq -r 'to_entries | .[] | "\(.value.txHash)#\(.value.index)"' ./wallet/utxos.json | awk '{print "--tx-in "$0}' | xargs)
UTXO_COUNT=$(jq length ./wallet/utxos.json)


echo $IN_UTXO