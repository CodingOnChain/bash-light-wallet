POLICY_SCRIPT=$1
POLICY_ID=$2
TOKEN_NAME=$3
TOKEN_AMOUNT=$4
METADATA_JSON_FILE=$5
PAYMENT_SECRET_KEY=$6
POLICY_SECRET_KEY=$7
SOURCE_ADDRESS=$8
DESTINATION_ADDRESS=$SOURCE_ADDRESS
DESTINATION_ADDRESS=addr1qygwvx84nhtxq9d2h76d4h3gx6v0evt0javcr546uv3g2vym5e0dmxnfwwjtd36yth827fp7tgegy4ltyy7ftk4g6f2q2w2g9n

#                           TxHash                                 TxIx        Amount
#--------------------------------------------------------------------------------------
#47c4c841f59ffe0a4862df2d640a5abf2fb8778577230f61c6fc48ffb5390997     0        17000000 lovelace

# 16551007

IN_UTXO=c80d4ac4d47039b661648a0969595d7ad1de56275e97ff26b6b0b92c7cdd639b
BALANCE=15473335

cardano-cli transaction build-raw \
            --fee 0 \
            --tx-in="${IN_UTXO}#0" \
            --tx-out="${DESTINATION_ADDRESS}+${BALANCE} lovelace+100000000 7fefb99ca9af53fe5eb520c8302cef5214c631454355f51439d6c737.havefunTokenCRAZY+1 7fefb99ca9af53fe5eb520c8302cef5214c631454355f51439d6c737.havefunToken2+3 7fefb99ca9af53fe5eb520c8302cef5214c631454355f51439d6c737.haveFun+${TOKEN_AMOUNT} ${POLICY_ID}.${TOKEN_NAME}" \
            --minting-script-file ${POLICY_SCRIPT} \
            --mint="${TOKEN_AMOUNT} ${POLICY_ID}.${TOKEN_NAME}" \
            --metadata-json-file $METADATA_JSON_FILE \
            --out-file ${TOKEN_NAME}.txbody-draft

MIN_FEE=$(cardano-cli transaction calculate-min-fee \
                      --tx-body-file ${TOKEN_NAME}.txbody-draft \
                      --tx-in-count 1 \
                      --tx-out-count 1 \
                      --witness-count 2 \
                      --byron-witness-count 0 \
                      --protocol-params-file wallet/protocol-parameters.json | awk '{print $1}')

FINAL_BALANCE=$(expr ${BALANCE} - $MIN_FEE)

cardano-cli transaction build-raw \
            --fee ${MIN_FEE} \
            --tx-in="${IN_UTXO}#0" \
            --tx-out="${DESTINATION_ADDRESS}+${FINAL_BALANCE} lovelace+100000000 7fefb99ca9af53fe5eb520c8302cef5214c631454355f51439d6c737.havefunTokenCRAZY+1 7fefb99ca9af53fe5eb520c8302cef5214c631454355f51439d6c737.havefunToken2+3 7fefb99ca9af53fe5eb520c8302cef5214c631454355f51439d6c737.haveFun+${TOKEN_AMOUNT} ${POLICY_ID}.${TOKEN_NAME}" \
            --minting-script-file ${POLICY_SCRIPT} \
            --mint="${TOKEN_AMOUNT} ${POLICY_ID}.${TOKEN_NAME}" \
            --metadata-json-file $METADATA_JSON_FILE \
            --out-file ${TOKEN_NAME}.txbody


cardano-cli transaction sign \
            --mainnet \
            --signing-key-file ${PAYMENT_SECRET_KEY} \
            --signing-key-file ${POLICY_SECRET_KEY} \
            --tx-body-file  ${TOKEN_NAME}.txbody \
            --out-file      ${TOKEN_NAME}.tx.signed

