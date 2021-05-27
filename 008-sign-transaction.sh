
PAYMENT_SKEY=$1
TX_FILE=$2
cardano-cli transaction sign \
        --testnet-magic 1097911063 \
        --signing-key-file ${PAYMENT_SKEY} \
        --tx-body-file ${TX_FILE} \
        --out-file ./wallet/tx.signed
