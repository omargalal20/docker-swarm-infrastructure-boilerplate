variable "vpc" {
  type = any
}

variable "namespace" {
  description = "The namespace of the project"
  type        = string
}

variable "database_config" {
  description = "Configuration for the database instance"
  type = object({
    instance_class             = string
    engine                     = string
    engine_version             = string
    password                   = string
    username                   = string
    name                       = string
    allocated_storage          = number
    backup_retention           = number
    instance_identifier        = string
    storage_type               = string
    port                       = number
    security_group_ids         = list(string)
    auto_minor_version_upgrade = bool
    skip_final_snapshot        = bool
    multi_az                   = bool
    storage_encrypted          = bool
  })
}

