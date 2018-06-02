// General

variable "aws_credentials_profile" {
  type = "string"
}

// Deploy time

variable "aws_resource_name_deploy" {
  type    = "string"
  default = "alexa-deploy"
}

variable "deploy_bucket_name" {
  type = "string"
}

// Run time

variable "aws_resource_name_run" {
  type    = "string"
  default = "alexa-run"
}

variable "env_ALEXA_SKILL_ID" {
  type = "string"
}

