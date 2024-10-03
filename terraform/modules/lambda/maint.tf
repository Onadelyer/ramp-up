locals {
  function_name    = var.function_name
  handler          = var.handler
  runtime          = var.runtime
  lambda_role_arn  = var.lambda_role_arn
  code_bucket_name = var.code_bucket_name
  code_object_key  = var.code_object_key
  package_path     = var.package_path
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = local.package_path
  output_path = "${local.package_path}.zip"
}

resource "aws_lambda_function" "lambda_function" {
  function_name = local.function_name
  handler       = local.handler
  runtime       = local.runtime
  role          = local.lambda_role_arn
  s3_bucket     = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key        = aws_s3_object.lambda_code_object.key
}

resource "aws_s3_bucket" "lambda_code_bucket" {
  bucket = local.code_bucket_name
}

resource "aws_s3_object" "lambda_code_object" {
  bucket = aws_s3_bucket.lambda_code_bucket.bucket
  key    = local.code_object_key
  source = data.archive_file.lambda_zip.output_path
  etag   = filemd5(data.archive_file.lambda_zip.output_path)
}

resource "aws_lambda_alias" "function_alias" {
  name             = "lambda_alias"
  description      = "Latest version of lambda function"
  function_name    = aws_lambda_function.lambda_function.function_name
  function_version = "$LATEST"
}
