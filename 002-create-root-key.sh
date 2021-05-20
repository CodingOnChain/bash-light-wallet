MNEMONICS_PRIV_FILE=$1
ROOT_PRIV_KEY_FILE=$2

cat $MNEMONICS_PRIV_FILE | cardano-address key from-recovery-phrase Shelley > $ROOT_PRIV_KEY_FILE