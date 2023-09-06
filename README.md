# bb1629be

`bb1629be` は「新しい技術の組み合わせ」という文言のCRC32チェックサム

## summary

TODO

## [Backend](./backend/README.md)
## [Frontend](./frontend/README.md)

## env

### python

```
❯ python3 -V
Python 3.9.6
```

### gcloud cli

https://cloud.google.com/sdk/docs/install?hl=ja

```
❯ gcloud version                   
Google Cloud SDK 444.0.0
bq 2.0.97
core 2023.08.22
gcloud-crc32c 1.0.0
gsutil 5.25
```

## terraform

### auth

```
gcloud auth application-default login
```

### remote store

```
gsutil mb -l asia-northeast1 gs://tf-state-bb1629be-prd
```

### ope

```
terraform init --upgrade
```

```
terraform fmt --recursive
terraform validate
tflint
```

- tflint : https://github.com/terraform-linters/tflint

```
terraform plan --out plan.tfplan
```

```
terraform apply "plan.tfplan"
```
