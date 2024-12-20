data "aws_ami" "latest_amazon_linux_image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "tf_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.key_pair_file_path
}

resource "aws_iam_instance_profile" "docker-swarm-manager_instance_profile" {
  name = "${var.namespace}-docker-swarm-manager-instance-profile"
  role = var.iam_role_name
}

resource "aws_instance" "docker_swarm_master_node_instance" {
  count                       = var.master_node_count
  ami                         = data.aws_ami.latest_amazon_linux_image.id
  instance_type               = var.manager_node_config.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.manager_node_config.subnet_id
  vpc_security_group_ids      = [var.manager_node_config.security_group_id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.docker-swarm-manager_instance_profile.name

  root_block_device {
    volume_size = var.manager_node_config.storage
  }

  tags = {
    Name = "${var.namespace}-docker-swarm-master-node-${count.index}"
  }

  depends_on = [aws_key_pair.tf_key_pair]
}

resource "aws_instance" "docker_swarm_worker_node_instance" {
  count                       = var.worker_node_count
  ami                         = data.aws_ami.latest_amazon_linux_image.id
  instance_type               = var.worker_node_config.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.worker_node_config.subnet_id
  vpc_security_group_ids      = [var.worker_node_config.security_group_id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.worker_node_config.storage
  }

  tags = {
    Name = "${var.namespace}-docker-swarm-worker-node-${count.index}"
  }

  depends_on = [aws_key_pair.tf_key_pair]
}
