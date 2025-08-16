output "iam_user_names" {
    description = "Names of the IAM Users"
    value = aws_iam_user.users[*].name
}

output "iam_access_keys" {
  description = "Access keys for IAM users"
  value       = aws_iam_access_key.user_keys[*].id
  sensitive   = true
}

output "iam_secret_keys" {
  description = "Secret keys for IAM users"
  value       = aws_iam_access_key.user_keys[*].secret
  sensitive   = true
}
