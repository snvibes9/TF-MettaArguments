resource "aws_iam_user" "users" {
    count = length(var.iam_user_names)
    name = var.iam_user_names[count.index]
    
    tags = {
        Name = var.iam_user_names[count.index]
    }
}

resource "aws_iam_access_key" "user_keys" {
    count = length(var.iam_user_names)
    user = aws_iam_user.users[count.index].name

}

# Attach AdministratorAccess
resource "aws_iam_user_policy_attachment" "admin_policy" {
  count      = length(var.iam_user_names)
  user       = aws_iam_user.users[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Attach CloudWatch ReadOnly Access
resource "aws_iam_user_policy_attachment" "cloudwatch_readonly" {
  count      = length(var.iam_user_names)
  user       = aws_iam_user.users[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

# Attach S3 ReadOnly Access
resource "aws_iam_user_policy_attachment" "s3_readonly" {
  count      = length(var.iam_user_names)
  user       = aws_iam_user.users[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
