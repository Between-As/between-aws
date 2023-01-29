resource "aws_iam_policy" "codebuild_policy" {
  name   = "${local.tag_environment}-codedeploy-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.codebuild_iam_policy.json
}

resource "aws_iam_role" "codebuild_role" {
  name               = "${local.tag_environment}-codedeploy-role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.codebuild_iam_role_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "codebuild_permissions" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}