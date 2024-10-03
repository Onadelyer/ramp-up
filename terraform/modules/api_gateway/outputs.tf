output "api_gateway_rest_api_arn" {
  description = "The ARN of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.api.arn
}

output "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = aws_api_gateway_rest_api.api.id
}

output "api_gateway_execution_arn" {
  description = "The ARN of the API Gateway execution role"
  value       = aws_api_gateway_rest_api.api.execution_arn
}
