terraform {
  backend "s3" {
    bucket  = "dev-qiita-bucket-s3"
    key     = "dev/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
