terraform {
  backend "s3" {
    bucket  = "prepare-qiita-bucket-s3"
    key     = "prepare/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
