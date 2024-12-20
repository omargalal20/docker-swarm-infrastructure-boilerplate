locals {
  namespace = "${var.project_name}-${var.env_name}"
}

module "network" {
  source       = "../../modules/providers/aws/network"
  region       = var.region
  project_name = var.project_name
  env_name     = var.env_name
  namespace    = local.namespace
}

module "iam" {
  source       = "../../modules/providers/aws/iam"
  project_name = var.project_name
  env_name     = var.env_name
  namespace    = local.namespace
}

module "manager_security_group" {
  source = "../../modules/providers/aws/security-group"
  name   = "${local.namespace}-docker-swarm-manager-node-sg"
  vpc_id = module.network.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 2376
      to_port     = 2376
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 2377
      to_port     = 2377
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 7946
      to_port     = 7946
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 7946
      to_port     = 7946
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 4789
      to_port     = 4789
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "worker_security_group" {
  source = "../../modules/providers/aws/security-group"
  name   = "${local.namespace}-docker-swarm-worker-node-sg"
  vpc_id = module.network.vpc_id

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 7946
      to_port     = 7946
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 7946
      to_port     = 7946
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 4789
      to_port     = 4789
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "docker_swarm" {
  source             = "../../modules/providers/aws/docker-swarm"
  vpc                = module.network.vpc
  region             = var.region
  project_name       = var.project_name
  env_name           = var.env_name
  namespace          = local.namespace
  master_node_count  = 1
  worker_node_count  = 1
  key_name           = "${local.namespace}-docker-swarm-key-pair"
  key_pair_file_path = var.DOCKER_SWARM_KEY_PAIR_PATH
  iam_role_name      = module.iam.cicd_iam_role_name

  manager_node_config = {
    instance_type     = "t3.micro"
    storage           = 40
    subnet_id         = module.network.public_subnets[0]
    security_group_id = module.manager_security_group.security_group_id
  }

  worker_node_config = {
    instance_type = "t3.micro"
    storage       = 30
    subnet_id     = module.network.public_subnets[1]
    security_group_id = module.worker_security_group.security_group_id
  }
}
