function cardano-wallet-parse-utxos-balances() {

  WALLET_NAME=$1
  cardano-wallet-mainnet-init ${WALLET_NAME}

  rm -rf ${BALANCES_DIR} && mkdir -p ${BALANCES_DIR}

  echo "$(jq -r .[].value ${WALLET_DIR}/utxos.json | awk '{s+=$1} END {printf "%.0f", s}')" > ${BALANCES_DIR}/balance.lovelace

  jq -r 'to_entries | .[] | .value.tokens[] | "\(.quantity) \(.policyId).\(.assetName)"' ${WALLET_DIR}/utxos.json > ${BALANCES_DIR}/hextoken.balances

  cp -a ${BALANCES_DIR}/hextoken.balances ${BALANCES_DIR}/token.balances

  awk '{print $2}' ${BALANCES_DIR}/hextoken.balances | awk -F. '{print $2}' | while read line; do sed -i -e "s|${line}|$(echo $line | xxd -r -p)|g" -e 's|\\||g' ${BALANCES_DIR}/token.balances; done

  awk '{print $2}' ${BALANCES_DIR}/token.balances | uniq | while read token; do grep ${token} ${BALANCES_DIR}/token.balances | awk '{s+=$1} END {print s}' > ${BALANCES_DIR}/balance.${token}; done

}

