WALLETS_DIR=$HOME/.config/bash-light-wallet

# parse arguments
WALLET_NAME=$1
MNEMONICS_SIZE=$2

WALLET_DIR=$WALLETS_DIR/$WALLET_NAME
MNEMONICS_PRIV_FILE=$WALLET_DIR/mnemonics.private
mkdir -p $WALLET_DIR

cardano-address recovery-phrase generate --size $MNEMONICS_SIZE > $MNEMONICS_PRIV_FILE