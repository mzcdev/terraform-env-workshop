#!/bin/bash

OS_NAME="$(uname | awk '{print tolower($0)}')"

command -v fzf > /dev/null && FZF=true
command -v tput > /dev/null && TPUT=true

_echo() {
    if [ "${TPUT}" != "" ] && [ "$2" != "" ]; then
        echo -e "$(tput setaf $2)$1$(tput sgr0)"
    else
        echo -e "$1"
    fi
}

_result() {
    echo
    _echo "# $@" 4
}

_command() {
    echo
    _echo "$ $@" 3
}

_success() {
    echo
    _echo "+ $@" 2
    exit 0
}

_error() {
    echo
    _echo "- $@" 1
    exit 1
}

_replace() {
    if [ "${OS_NAME}" == "darwin" ]; then
        sed -i "" -e "$1" "$2"
    else
        sed -i -e "$1" "$2"
    fi
}

_find_replace() {
    if [ "${OS_NAME}" == "darwin" ]; then
        find . -name "$2" -exec sed -i "" -e "$1" {} \;
    else
        find . -name "$2" -exec sed -i -e "$1" {} \;
    fi
}

# variable
export ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)

echo "ACCOUNT_ID=${ACCOUNT_ID}"

export REGION="ap-northeast-2"
export BUCKET="terraform-workshop-${1:-${ACCOUNT_ID}}"

echo "REGION=${REGION}"
echo "BUCKET=${BUCKET}"

export BASE_DOMAIN="${TF_VAR_base_domain:-demo.spic.me}"

echo "BASE_DOMAIN=${BASE_DOMAIN}"

if [ "${TF_VAR_base_domain}" == "" ]; then
    _error "BASE_DOMAIN is empty."
fi

# replace
_find_replace "s/terraform-workshop-[[:alnum:]]*/${BUCKET}/g" "*.tf"

_find_replace "s/demo.spic.me/${BASE_DOMAIN}/g" "*.yaml"
_find_replace "s/demo.spic.me/${BASE_DOMAIN}/g" "*.json"

_replace "s/GOOGLE_CLIENT_ID/${TF_VAR_google_client_id}/g" ./eks-charts/template/keycloak-realm.json
_replace "s/GOOGLE_CLIENT_SECRET/${TF_VAR_google_client_secret}/g" ./eks-charts/template/keycloak-realm.json

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
