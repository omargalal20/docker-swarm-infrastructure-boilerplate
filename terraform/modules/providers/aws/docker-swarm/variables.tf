variable "vpc" {
  type = any
}

variable "region" {
  description = "AWS Region"
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

variable "namespace" {
  description = "The namespace of the project"
  type        = string
}

variable "master_node_count" {
  description = "The number master of the project"
  type        = string
}

variable "worker_node_count" {
  description = "The number worker nodes of the project"
  type        = string
}

variable "manager_node_config" {
  description = "Configuration for manager nodes"
  type = object({
    instance_type     = string
    storage           = number
    subnet_id         = string
    security_group_id = string
  })
}

variable "worker_node_config" {
  description = "Configuration for worker nodes"
  type = object({
    instance_type     = string
    storage           = number
    subnet_id         = string
    security_group_id = string
  })
}

variable "key_pair_file_path" {
  description = "The docker swarm key pair file path of the project"
  type        = string
}

variable "key_name" {
  description = "The docker swarm key name credentials of the project"
  type        = string
}

variable "iam_role_name" {
  description = "The iam role name of the docker swarm manager nodes of the project"
  type        = string
}
