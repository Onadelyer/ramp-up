terraform {
  backend "s3" {
    bucket  = "sample445-ftstate"
    key     = "backend/tf.tfstate"
    region  = "us-east-1"
  }
}
