# 
# aws lambda module: https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest
# simple example: https://github.com/terraform-aws-modules/terraform-aws-lambda/tree/v2.29.0/examples/simple

locals {
  function_name = "randomword"
}
module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "2.29.0"
  
  architectures = [ "x86_64" ]
  function_name = "${var.project}-${var.environment}-${local.function_name}"
  handler = "index.lambda_handler"
  runtime = "python3.9"
  publish = true
  source_path = "./index.py"

   tags = merge(var.default-tags, { ProvisionedOn = "${local.today}" })
}
