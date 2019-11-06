# terraform-env-workshop

## requirements

```bash
# variable
REGION=ap-northeast-2
BUCKET=terraform-workshop-seoul

# create s3 bucket
aws s3 mb s3://${BUCKET} --region ${REGION}

# create dynamodb table
aws dynamodb create-table \
    --table-name ${BUCKET} \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --region ${REGION}
```

## clone

```bash
git clone https://github.com/mzcdev/terraform-env-workshop
```

## usage

### vpc

```bash
cd terraform-env-workshop/vpc

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
```

### lambda api

```bash
cd terraform-env-workshop/lambda

terraform init
terraform plan
terraform apply

curl -sL -X POST -d "{\"data\":\"ok\"}" ${invoke_url}/demo | jq .
```
