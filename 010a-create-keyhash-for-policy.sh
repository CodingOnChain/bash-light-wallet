POLICY_PUBLIC_KEY_FILE=$1
POLICY_KEY_HASH_FILE=$2

cardano-cli address key-hash --payment-verification-key-file $POLICY_PUBLIC_KEY_FILE > $POLICY_KEY_HASH_FILE
