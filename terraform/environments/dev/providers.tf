provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Environment = "Development"
      Project     = "Docker Swarm Boilerplate"
      Owner       = "Terraform"
    }
  }
}
