variable "environment" {
  type = string
  default = "staging"
  description = "The name of the environment for this resource, for example staging, production, development"
}

variable "project" {
   type = string
   default = "words"
}

variable "default-tags" {
   type = map(string)
   default = {
      Provisioner = "Terraform"
      Environment = "staging"
      Project = "words"
   }
   description = "A map of tags for the resource. For example { Project = \"ProjectAlpha\", Owner = \"John Doe\"}"
}


locals {
   timestamp = timestamp()
   today = formatdate("MMM DD YYYY", local.timestamp)
}

