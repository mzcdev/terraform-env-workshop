#!/bin/bash

OS_NAME="$(uname | awk '{print tolower($0)}')"

# variable
export ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)

echo "ACCOUNT_ID=${ACCOUNT_ID}"

export REGION="ap-northeast-2"
export BUCKET="terraform-workshop-${1:-${ACCOUNT_ID}}"

echo "REGION=${REGION}"
echo "BUCKET=${BUCKET}"

export BASE_DOMAIN="${TF_VAR_base_domain:-demo.spic.me}"

echo "BASE_DOMAIN=${BASE_DOMAIN}"

# replace workshop name
if [ "${OS_NAME}" == "darwin" ]; then
    find . -name '*.tf' -exec sed -i '' -e "s/terraform-workshop-[[:alnum:]]*/${BUCKET}/g" {} \;
    find . -name '*.yaml' -exec sed -i '' -e "s/demo.spic.me/${BASE_DOMAIN}/g" {} \;
    find . -name '*.json' -exec sed -i '' -e "s/demo.spic.me/${BASE_DOMAIN}/g" {} \;
else
    find . -name '*.tf' -exec sed -i -e "s/terraform-workshop-[[:alnum:]]*/${BUCKET}/g" {} \;
    find . -name '*.yaml' -exec sed -i -e "s/demo.spic.me/${BASE_DOMAIN}/g" {} \;
    find . -name '*.json' -exec sed -i -e "s/demo.spic.me/${BASE_DOMAIN}/g" {} \;
fi

# create s3 bucket
COUNT=$(aws s3 ls | grep ${BUCKET} | wc -l | xargs)
if [ "x${COUNT}" == "x0" ]; then
    echo "$ aws s3 mb s3://${BUCKET} --region ${REGION}"
    aws s3 mb s3://${BUCKET} --region ${REGION}
fi

# create dynamodb table
COUNT=$(aws dynamodb list-tables | jq -r .TableNames | grep ${BUCKET} | wc -l | xargs)
if [ "x${COUNT}" == "x0" ]; then
    echo "$ aws dynamodb create-table --table-name ${BUCKET}"
    aws dynamodb create-table \
        --table-name ${BUCKET} \
        --attribute-definitions AttributeName=LockID,AttributeType=S \
        --key-schema AttributeName=LockID,KeyType=HASH \
        --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
        --region ${REGION} | jq .
fi
