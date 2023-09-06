# 環境ごとに変わる
terraform {
  backend "gcs" {
    bucket = "tf-state-bb1629be-prd"
  }
}
