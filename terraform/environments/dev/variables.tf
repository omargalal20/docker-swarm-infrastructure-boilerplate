variable "region" {
  description = "AWS Region"
  default     = "us-west-2"
  type        = string
}

variable "profile" {
  description = "The AWS CLI profile of the project"
  default     = "docker-swarm-boilerplate"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "env_name" {
  description = "The environment name of the project"
  type        = string
}