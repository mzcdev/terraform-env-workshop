#!/bin/bash

OS_NAME="$(uname | awk '{print tolower($0)}')"

# variable
export ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)

echo "ACCOUNT_ID=${ACCOUNT_ID}"

export REGION="ap-northeast-2"
export BUCKET="terraform-workshop-${ACCOUNT_ID}"

echo "REGION=${REGION}"
echo "BUCKET=${BUCKET}"

if [ "${OS_NAME}" == "darwin" ]; then
    find . -name '*.tf' -exec sed -i '' -e "s/terraform-workshop-[[:alnum:]]/${BUCKET}/g" {} \;
else
    find . -name '*.tf' -exec sed -i -e "s/terraform-workshop-[[:alnum:]]/${BUCKET}/g" {} \;
fi
