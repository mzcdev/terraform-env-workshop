# terraform-env-workshop

## clone

```bash
git clone https://github.com/mzcdev/terraform-env-workshop

cd terraform-env-workshop
```

## setup

```bash
./setup.sh

# # variable
# export ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)

# export REGION="ap-northeast-2"
# export BUCKET="terraform-workshop-${ACCOUNT_ID}"

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

## usage

### vpc

```bash
cd ./vpc

terraform init
terraform plan
terraform apply
```

### bastion

```bash
cd ./bastion

terraform init
terraform plan
terraform apply
```

### eks

```bash
cd ./eks

terraform init
terraform plan
terraform apply

kubectl get no
kubectl get ns
kubectl get pod --all-namespaces
kubectl get ing --all-namespaces
```

### eks-charts

```bash
cd ./eks-charts

terraform init
terraform plan
terraform apply

kubectl get no
kubectl get ns
kubectl get pod --all-namespaces
kubectl get ing --all-namespaces
```

### lambda api

```bash
cd ./lambda

terraform init
terraform plan
terraform apply

curl -sL -X POST -d "{\"data\":\"ok\"}" ${invoke_url}/demo | jq .
```
