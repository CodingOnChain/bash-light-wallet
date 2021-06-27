SOURCE_ADDRESS=$1
DESTINATION_ADDRESS=$2
AMOUNT_TO_SEND=$3
FEE=$4
BALANCE=$5 # 2234000000

cardano-cli transaction build-raw \
    --fee $FEE \
    --tx-in e50f898065bb8c7dd573ca9663133c71057e12782a243925ee72aec7f4fe57de#0 --tx-in fc11c603e09f57f0fea4e9bb2c8c8cf6e6af3e7c08a6bb2bf737117c2c34741a#0 \
    --tx-out="${DESTINATION_ADDRESS}+${AMOUNT_TO_SEND} lovelace" \
    --tx-out="${SOURCE_ADDRESS}+$(( ${BALANCE} - ${AMOUNT_TO_SEND} - ${FEE} )) lovelace " \
    --out-file ./wallet/tx.raw