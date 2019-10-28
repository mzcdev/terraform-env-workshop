# terraform-env-workshop

## usage

```bash
REGION=ap-northeast-2
BUCKET=terraform-workshop-seoul

# create bucket
aws s3 mb s3://${BUCKET} --region ${REGION}

# create dynamodb
aws dynamodb create-table \
    --table-name ${BUCKET} \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --region ${REGION}
```
