resource "aws_s3_bucket" "buckets" {
  count  = length(var.s3_bucket_names)
  bucket = var.s3_bucket_names[count.index]

  tags = {
    Name = var.s3_bucket_names[count.index]
  }
}

# NEW: ACL moved to separate resource
resource "aws_s3_bucket_acl" "buckets_acl" {
  count  = length(var.s3_bucket_names)
  bucket = aws_s3_bucket.buckets[count.index].id
  acl    = "private"  # You can still change to "public-read", etc., if required
}

resource "aws_s3_bucket_versioning" "buckets" {
  count  = length(var.s3_bucket_names)
  bucket = aws_s3_bucket.buckets[count.index].id

  versioning_configuration {
    status = "Enabled"
  }
}

# Example SNS topic to receive S3 event notifications
resource "aws_sns_topic" "s3_events" {
  name = "s3-event-topic"
}

# Allow S3 to publish to the SNS topic
resource "aws_sns_topic_policy" "s3_topic_policy" {
  arn    = aws_sns_topic.s3_events.arn
  policy = data.aws_iam_policy_document.s3_sns_topic_policy.json
}

data "aws_iam_policy_document" "s3_sns_topic_policy" {
  statement {
    sid     = "AllowS3Publish"
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = [
      "SNS:Publish"
    ]

    resources = [
      aws_sns_topic.s3_events.arn
    ]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [for bucket in aws_s3_bucket.buckets : bucket.arn]
    }
  }
}

# Event notification for object created events in the bucket
resource "aws_s3_bucket_notification" "bucket_notifications" {
  count  = length(var.s3_bucket_names)
  bucket = aws_s3_bucket.buckets[count.index].id

  topic {
    topic_arn = aws_sns_topic.s3_events.arn
    events    = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_s3_bucket.buckets, aws_sns_topic_policy.s3_topic_policy]
}
