variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "Handler for the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
}

variable "package_path" {
  description = "Path to the deployment package or S3 bucket/object details"
  type        = string
}

variable "invoking_service_name" {
  description = "Name of the service invoking the Lambda function (e.g., APIGateway)"
  type        = string
}

variable "invoking_service_principal" {
  description = "Principal of the service invoking the Lambda function (e.g., apigateway.amazonaws.com)"
  type        = string
}

variable "code_bucket_name" {
  description = "Name of the S3 bucket for Lambda code"
  type        = string
}

variable "code_object_key" {
  description = "S3 object key for the Lambda deployment package"
  type        = string
}

variable "lambda_role_arn" {
  description = "ARN of the IAM role that the Lambda function assumes"
  type        = string
}
