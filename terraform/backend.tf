terraform {
  backend "s3" {
    bucket = "sample445-tfstate"
    key    = "backend/tf.tfstate"
    region = "us-east-1"
  }
}
