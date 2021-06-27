POLICY_SCRIPT_FILE=$1
POLICY_ID_FILE=$2

cardano-cli transaction policyid --script-file $POLICY_SCRIPT_FILE > $POLICY_ID_FILE
