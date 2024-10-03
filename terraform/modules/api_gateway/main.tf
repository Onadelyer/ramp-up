locals {
  name         = var.name
  lambda_arn   = var.lambda_arn
  lambda_alias = var.lambda_alias
  lambda_name  = var.lambda_name
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "${local.name}-api"
  description = "API for AWS Lambda"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

module "api_method" {
  source = "./modules/api_method"

  api_id                    = aws_api_gateway_rest_api.api.id
  resource_id               = aws_api_gateway_rest_api.api.root_resource_id
  http_method               = "GET"
  lambda_arn                = local.lambda_arn
  lambda_alias              = local.lambda_alias
  api_gateway_execution_arn = aws_api_gateway_rest_api.api.execution_arn
  lambda_name               = local.lambda_name
}

resource "aws_api_gateway_deployment" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  depends_on = [module.api_method]

  stage_name = "run"
}


