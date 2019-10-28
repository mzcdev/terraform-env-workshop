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
git clone https://github.com/nalbam/terraform-env-workshop
```

## usage

```bash
# create vpc
cd terraform-env-workshop/vpc

terraform init
terraform plan
terraform apply

# c reate eks
cd terraform-env-workshop/eks

terraform init
terraform plan
terraform apply
```
