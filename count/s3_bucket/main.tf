resource "aws_s3_bucket" "buckets" {
    count = length(var.s3_bucket_names)
    bucket = var.s3_bucket_names[count.index]

    tags = {
        Name = var.s3_bucket_names[count.index]
    }

}

resource "aws_s3_bucket_versioning" "buckets" {
    count = length(var.s3_bucket_names)
    bucket = aws_s3_bucket.buckets[count.index].id
    versioning_configuration {
        status = "Enabled"
    }
}

