# MODULE RESOURCES
resource "aws_iam_user" "user" {
  name = var.user_name
  tags = var.tags
}
resource "aws_iam_user_login_profile" "profile" {
  user    = aws_iam_user.user.name
  pgp_key = "keybase:nana" # outside our scope
  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}
resource "aws_iam_group" "group" {
  name = var.group_name
}
resource "aws_iam_user_group_membership" "membership" {
  user = aws_iam_user.user.name
  groups = [
    aws_iam_group.group.name,
  ]
}
