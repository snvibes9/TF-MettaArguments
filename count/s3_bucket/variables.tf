variable "s3_bucket_names" {
    description = "List of s3 bucket names"
    type = list(string)
    default = ["my-app-bucket-001", "my-backup-bucket-002"]
}

