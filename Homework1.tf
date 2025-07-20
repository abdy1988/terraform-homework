provider "aws" {
  region = "us-east-1" 
}

resource "aws_iam_user" "kpop-users"{
  for_each = toset(["jenny", "rose","lisa","jisoo"])
  name = each.value
}

resource "aws_iam_user" "kpop_users2"{
  for_each = toset (["jihyo", "sana", "momo", "dahyun"])
  name =each.value
}
resource "aws_iam_group" "kpop_group"{
  for_each = toset (["blackpink", "twice"])
  name = each.value
}

resource "aws_iam_user_group_membership" "blackpink_membership" {
  for_each = toset(["jenny", "rose", "lisa", "jisoo", "miyeon"])
  user     = aws_iam_user.kpop-users[each.value].name
  groups   = [aws_iam_group.kpop_group["blackpink"].name]
}

resource "aws_iam_user_group_membership" "twice_membership" {
  for_each = toset(["jihyo", "sana", "momo", "dahyun", "mina"])
  user     = aws_iam_user.kpop_users2[each.value].name
  groups   = [aws_iam_group.kpop_group["twice"].name]
}


