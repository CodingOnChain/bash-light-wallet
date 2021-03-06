TX_FILE=$1
NETWORK=$2
CBOR_HEX=$(jq -r .cborHex "${TX_FILE}")

  cat >./wallet/query<<EOF
{ "query": "mutation submitTransaction( \$transaction: String! ) { submitTransaction(transaction: \$transaction) { hash } }", "variables": { "transaction": "${CBOR_HEX}" } }
EOF

  curl -s https://graphql-api.${NETWORK}.dandelion.link \
    -H 'Content-Type: application/json' -H 'Accept: application/json' \
    --data-binary @./wallet/query
