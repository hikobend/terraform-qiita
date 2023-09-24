terraform {
  backend "s3" {
    bucket  = "prepare-qiita-bucket-s3"
    key     = "envs/dev/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
