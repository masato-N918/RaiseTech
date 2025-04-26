# backendの定義
terraform {
  backend "s3" {
    bucket = "tf-lecture33-nakama"
    key    = "lecture33/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
