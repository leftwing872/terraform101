resource "aws_iam_user" "for_each_map" {
  for_each = {
    heewon = {
      Team  = "TeamDevOps"
      Login = "True"
      Key   = "True"
    }
    jaehyun = {
      Team  = "TeamDev"
      Login = "True"
      Key   = "True"
    }
    jungwoo = {
      Team  = "TeamDatascience"
      Login = "True"
      Key   = "True"
    }
  }
  name = each.key
  tags = each.value
}
output "for_each_map_user_arns" {
  value = values(aws_iam_user.for_each_map).*.arn
}


