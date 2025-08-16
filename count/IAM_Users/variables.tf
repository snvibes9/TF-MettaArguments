variable "iam_user_names" {
    description = "List of the IAM users name"
    type = list(string)
    default = ["developer-user", "admin-user"]
    
}