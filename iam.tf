# Original resources in dynamodb_read_policy
# "arn:aws:dynamodb:us-east-1:014834224223:table/${module.dynamodb-table.dynamodb_table_id}/index/*",
# "arn:aws:dynamodb:us-east-1:014834224223:table/${module.dynamodb-table.dynamodb_table_id}"

# Resources that may be wrong
#  "${module.dynamodb-table.dynamodb_table_arn}/index/*",
#  "${module.dynamodb-table.dynamodb_table_arn}"

variable "apigw_invokefullaccess_policy" {
  default = "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess"
  description = <<EOF
    The ARN for the APiGatewayInvokeFullAccess Managed Policy to allow the 
    response via the websocket connection
  EOF
}


resource "aws_iam_policy" "dynamodb_read_policy" {
  name   = "${var.project}-${var.environment}-dynamodb_read_policy"
  policy = file("./dynamodb_read_policy.json")
  tags   = var.default-tags
}

resource "aws_iam_role" "lambda_role" {
  name                = "${var.project}-${var.environment}-lambda_assume_role_policy"
  assume_role_policy  = file("./lambda_assume_role.json")
  managed_policy_arns = [aws_iam_policy.dynamodb_read_policy.arn, 
                          var.apigw_invokefullaccess_policy]
}

