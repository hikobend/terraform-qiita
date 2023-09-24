terraform {
  backend "s3" {
    bucket  = "prepare-qiita-bucket-s3"
    key     = "envs/stg/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
