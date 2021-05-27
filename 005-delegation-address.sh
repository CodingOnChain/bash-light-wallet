ENTERPRISE_ADDRESS_FILE=$1
STAKE_PUB_KEY_FILE=$2
DELEGATION_ADDR_FILE=$3

cat $1 | cardano-address address delegation $(cat $2) > $3
