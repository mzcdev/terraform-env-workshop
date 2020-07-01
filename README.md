# terraform-env-workshop

## clone

```bash
git clone https://github.com/mzcdev/terraform-env-workshop

cd terraform-env-workshop
```

## setup

```bash
# for ingress
export TF_VAR_base_domain="demo.spic.me"
export TF_VAR_slack_token="REPLACEME"

# replace workshop name
# create s3 bucket
# create dynamodb table
./replace.sh
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

./replace.py

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
