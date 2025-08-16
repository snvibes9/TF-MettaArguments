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

