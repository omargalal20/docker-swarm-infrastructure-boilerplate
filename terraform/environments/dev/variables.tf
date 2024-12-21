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

# --- Secrets ---

variable "DOCKER_SWARM_KEY_PAIR_PATH" {
  description = "The local key pair path needed to store the Docker Swarm SSH key"
  type        = string
}

variable "DATABASE_NAME" {
  description = "The name for the database"
  type        = string
}

variable "DATABASE_PASSWORD" {
  description = "The password for the database"
  type        = string
}

variable "DATABASE_USER" {
  description = "The password for the database"
  type        = string
}
