resource "aws_iam_role" "project_assume_role" {
  name               = "${var.project_name}-role"
  description        = "This role will provide only the necessary permissions"
  assume_role_policy = data.aws_iam_policy_document.role_assume_policy.json
}

resource "aws_iam_role_policy" "project_role_policy" {
  name              = "${var.project_name}-role-policy"
  role              = aws_iam_role.project_assume_role.id
  policy            = data.aws_iam_policy_document.role_policy.json
}
