# 
# Reference: https://registry.terraform.io/modules/terraform-aws-modules/apigateway-v2/aws/latest
# 
module "apigateway-v2" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "1.5.1"
  # insert the 10 required variables 
  
  name = "${var.project}-${var.environment}-apigw"
  protocol_type = "WEBSOCKET"

  # create_default_stage_mapping = false
  # create_routes_and_integrations = 
  create_vpc_link = false
  create_api_domain_name = false
  route_selection_expression = "$request.body.action"
  tags = merge(var.default-tags, { ProvisionedOn = "${local.today}" })

  integrations = {
    "$default" = {
      lambda_arn = module.lambda.lambda_function_arn
    }
  }
}

output "urls" {
  description = "The urls for the stage"
  value = module.apigateway-v2.default_apigatewayv2_stage_invoke_url
  }
