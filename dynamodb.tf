#
# dynamodb-table module documentation is at https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws/latest
# A simple example is at https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table/blob/v1.1.0/examples/basic/main.tf
# 
# Provisions a dynamo_words table with partition key word, of type string

module "dynamodb-table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "1.1.0"

  name = "dynamo_words"
  hash_key = "word"

  attributes = [
     {
        name = "word"
         type = "S"
      }
  ]

  tags = merge(var.default-tags, { ProvisionedOn = "${local.today}" })
  
}

output "dynamodb_table_id" {
  description = "ID of the DynamoDB table"
  value       = module.dynamodb-table.dynamodb_table_id
}
