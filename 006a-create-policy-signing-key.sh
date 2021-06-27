# Inspired by https://gist.github.com/ilap/5af151351dcf30a2954685b6edc0039b#script <-- UNDR stake pool
PAYMENT_XPRV_KEY_FILE=$1
PAYMENT_XPUB_KEY_FILE=$2
PAYMENT_SKEY_FILE=$3

PESKEY=$( cat ${PAYMENT_XPRV_KEY_FILE} | bech32 | cut -b -64 )

cat << EOF > ${PAYMENT_SKEY_FILE}
{
    "type": "PaymentSigningKeyShelley_ed25519",
    "description": "Payment Signing Key",
    "cborHex": "5820$PESKEY"
}
EOF
