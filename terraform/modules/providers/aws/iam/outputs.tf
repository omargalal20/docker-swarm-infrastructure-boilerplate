
output "cicd_iam_role_name" {
  description = "IAM role name of the CI/CD instance"
  value       = aws_iam_role.cicd_iam_role.name
}
