terraform {
  backend "s3" {
    bucket = "tf-lecture43-nakama"
    key    = "lectur43/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
