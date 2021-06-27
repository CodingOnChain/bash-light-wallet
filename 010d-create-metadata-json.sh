export POLICY_ID=$1
export TOKEN_NAME=$2
export HTML_FILE=$3
export METADATA_JSON_TEMPLATE_FILE=$4

export SOURCE_ARRAY=$(echo "data:text/html;base64,"$(cat $HTML_FILE | base64) | sed 's| ||g' | fold -w 63 | jq -rcRs 'split("\n") | del(.[] |  select(. == ""))')

envsubst < $METADATA_JSON_TEMPLATE_FILE > /tmp/metadata.json
