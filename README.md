# terraform-env-workshop

## requirements

```bash
# variable
export ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)

export REGION="ap-northeast-2"
export BUCKET="terraform-workshop-${ACCOUNT_ID}"

./setup.sh

# # replace workshop name
# find . -name '*.tf' -exec sed -i -e "s/terraform-workshop-mzcdev/${BUCKET}/g" {} \;

# # create s3 bucket
# aws s3 mb s3://${BUCKET} --region ${REGION}

# # create dynamodb table
# aws dynamodb create-table \
#     --table-name ${BUCKET} \
#     --attribute-definitions AttributeName=LockID,AttributeType=S \
#     --key-schema AttributeName=LockID,KeyType=HASH \
#     --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
#     --region ${REGION}
```

## clone

```bash
git clone https://github.com/mzcdev/terraform-env-workshop
```

## usage

### lambda api

```bash
cd terraform-env-workshop/lambda

terraform init
terraform plan
terraform apply

curl -sL -X POST -d "{\"data\":\"ok\"}" ${invoke_url}/demo | jq .
```

### vpc

```bash
cd terraform-env-workshop/vpc

terraform init
terraform plan
terraform apply
```

### bastion

```bash
cd terraform-env-workshop/bastion

terraform init
terraform plan
terraform apply
```

### eks

```bash
cd terraform-env-workshop/eks

terraform init
terraform plan
terraform apply

kubectl get nodes
```
