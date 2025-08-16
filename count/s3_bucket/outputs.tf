output "s3_bucket_names" {
    description = "Names of the s3 bucket"
    value = aws_s3_bucket.buckets[*].bucket
}
