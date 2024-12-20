output "docker_swarm_manager_node_public_ip" {
  value = aws_instance.docker_swarm_master_node_instance.*.public_ip
}