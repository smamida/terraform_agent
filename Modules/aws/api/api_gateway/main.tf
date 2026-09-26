terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}

variable "name" {
  description = "Name of the HTTP API."
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the Lambda function used by the sample route."
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Invoke URI for the Lambda integration."
  type        = string
}

resource "aws_apigatewayv2_api" "this" {
  name          = var.name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "health" {
  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "health" {
  api_id             = aws_apigatewayv2_api.this.id
  route_key          = "GET /health"
  target             = "integrations/${aws_apigatewayv2_integration.health.id}"
  authorization_type = "AWS_IAM"
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowHttpApiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this.execution_arn}/*/GET/health"
}

output "api_endpoint" {
  description = "Invoke URL for the HTTP API."
  value       = aws_apigatewayv2_api.this.api_endpoint
}