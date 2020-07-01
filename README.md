# terraform-env-workshop

## clone

```bash
git clone https://github.com/mzcdev/terraform-env-workshop

cd terraform-env-workshop
```

## setup

```bash
# for ingress
export TF_VAR_base_domain="" # demo.nalbam.com

# for keycloak
# https://console.cloud.google.com/ : API 및 인증정보 > 사용자 인증 정보 > OAuth 2.0 클라이언트 ID
# 승인된 리디렉션 URI : https://keycloak.demo.spic.me/auth/realms/demo/broker/google/endpoint
export TF_VAR_google_client_id="REPLACEME.apps.googleusercontent.com"
export TF_VAR_google_client_secret="REPLACEME"

# for jenkins, alertmanager
export TF_VAR_slack_token="REPLACEME"

# replace
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
