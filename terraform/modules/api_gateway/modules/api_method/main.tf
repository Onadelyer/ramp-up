locals {
  api_id                    = var.api_id
  resource_id               = var.resource_id
  http_method               = var.http_method
  lambda_arn                = var.lambda_arn
  api_gateway_execution_arn = var.api_gateway_execution_arn
  lambda_alias              = var.lambda_alias
  lambda_name               = var.lambda_name
}

resource "aws_api_gateway_method" "this" {
  rest_api_id   = local.api_id
  resource_id   = local.resource_id
  http_method   = local.http_method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = local.api_id
  resource_id             = local.resource_id
  http_method             = aws_api_gateway_method.this.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = local.lambda_arn
}

resource "aws_api_gateway_method_response" "lambda" {
  rest_api_id = local.api_id
  resource_id = local.resource_id
  http_method = aws_api_gateway_method.this.http_method
  status_code = "200"
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = local.lambda_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${local.api_gateway_execution_arn}/run/*"
}
