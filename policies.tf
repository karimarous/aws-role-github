data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "role_assume_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${var.oidc_provider_name}"]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_provider_name}:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "${var.oidc_provider_name}:sub"
      values   = ["${var.repo_path}:*"]
    }
  }
}

data "aws_iam_policy_document" "role_policy" {
  statement {
    actions   = [
                 "s3:GetBucketAcl",
                 "s3:GetBucketCORS",
                 "s3:GetBucketWebsite",
                 "s3:GetBucketVersioning",
                 "s3:GetBucketLogging",
                 "s3:GetBucketTagging",
                 "s3:ListBucket"                ]
    resources = ["arn:aws:s3:::${var.project_name}-dev"]
  }
  statement {
    actions   = [
                 "s3:GetObject",
                 "s3:PutObject"
                ]
    resources = ["arn:aws:s3:::${var.project_name}-dev/*"]
  }
}