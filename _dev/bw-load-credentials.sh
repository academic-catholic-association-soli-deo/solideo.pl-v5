#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"
set -e

BW_SECRET_NAME="solideo_records_aws_credentials"

# bw (bitwarden) installation: `npm install -g @bitwarden/cli`
# If bw command is unavailable you may need to select correct version of nodejs
CREDENTIALS="$(bw get item "${BW_SECRET_NAME}")"
ACCESSKEYID=$(echo "${CREDENTIALS}" | jq '.fields[] | select(.name | contains("accesskeyid")) | .value')
SECRETACCESSKEY=$(echo "${CREDENTIALS}" | jq '.fields[] | select(.name | contains("secretaccesskey")) | .value')

echo "[default] 
aws_access_key_id=${ACCESSKEYID} 
aws_secret_access_key=${SECRETACCESSKEY}
" > "${DIR}/../.dvc/aws.credentials"
