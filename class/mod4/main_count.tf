# count를 사용하여 resource 작성
resource "aws_iam_user" "count_user" {
  count = 10
  name  = "count-user-${count.index}"
}

# output
output "count_user_arns" {
  value = aws_iam_user.count_user.*.arn
}


