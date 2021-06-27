KEYHASH_FILE=$1
POLICY_SCRIPT_FILE=$2

cat > $POLICY_SCRIPT_FILE <<EOF
{
  "type": "all",
  "scripts":
  [
    {
      "type": "sig",
      "keyHash": "$(cat $KEYHASH_FILE)"
    }
  ]
}
EOF
