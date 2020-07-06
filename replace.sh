#!/bin/bash

OS_NAME="$(uname | awk '{print tolower($0)}')"

# variable
export ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)

export REGION="ap-northeast-2"
export BUCKET="terraform-workshop-${1:-${ACCOUNT_ID}}"

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

_main() {
    _result "ACCOUNT_ID = ${ACCOUNT_ID}"

    _result "REGION = ${REGION}"
    _result "BUCKET = ${BUCKET}"

    _result "ROOT_DOMAIN = ${ROOT_DOMAIN}"
    _result "BASE_DOMAIN = ${BASE_DOMAIN}"

    if [ "${BASE_DOMAIN}" == "" ]; then
        _error "BASE_DOMAIN is empty."
    fi

    # replace
    _find_replace "s/terraform-workshop-[[:alnum:]]*/${BUCKET}/g" "*.tf"

    _find_replace "s/demo.mzdev.be/${BASE_DOMAIN}/g" "*.tf"
    _find_replace "s/demo.mzdev.be/${BASE_DOMAIN}/g" "*.yaml"
    _find_replace "s/demo.mzdev.be/${BASE_DOMAIN}/g" "*.json"

    _find_replace "s/mzdev.be/${ROOT_DOMAIN}/g" "*.tf"

    _find_replace "s/me@nalbam.com/${ADMIN_USERNAME}/g" "*.tf"

    _find_replace "s/GOOGLE_CLIENT_ID/${GOOGLE_CLIENT_ID}/g" "*.json"
    _find_replace "s/GOOGLE_CLIENT_SECRET/${GOOGLE_CLIENT_SECRET}/g" "*.json"

    _find_replace "s|SLACK_TOKEN|${SLACK_TOKEN}|g" "*.tf"

    # create s3 bucket
    COUNT=$(aws s3 ls | grep ${BUCKET} | wc -l | xargs)
    if [ "x${COUNT}" == "x0" ]; then
        _command "aws s3 mb s3://${BUCKET}"
        aws s3 mb s3://${BUCKET} --region ${REGION}
    fi

    # create dynamodb table
    COUNT=$(aws dynamodb list-tables | jq -r .TableNames | grep ${BUCKET} | wc -l | xargs)
    if [ "x${COUNT}" == "x0" ]; then
        _command "aws dynamodb create-table --table-name ${BUCKET}"
        aws dynamodb create-table \
            --table-name ${BUCKET} \
            --attribute-definitions AttributeName=LockID,AttributeType=S \
            --key-schema AttributeName=LockID,KeyType=HASH \
            --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
            --region ${REGION} | jq .
    fi
}

_main

_success
