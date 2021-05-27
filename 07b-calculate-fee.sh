cardano-cli transaction calculate-min-fee \
  --tx-body-file ./wallet/tx.draft \
  --tx-in-count 3 \
  --tx-out-count 2 \
  --witness-count 1 \
  --testnet-magic 1097911063 \
  --protocol-params-file ./wallet/protocol-parameters.json