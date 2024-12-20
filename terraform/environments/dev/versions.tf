terraform {
  required_version = ">=1.2.3"

  backend "s3" {
    bucket  = "docker-swarm-boilerplate-dev-terraform-state-bucket"
    key     = "terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
    profile = "docker-swarm-boilerplate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }
  }
}

