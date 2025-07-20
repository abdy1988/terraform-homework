import {
  to = aws_iam_user.kpop-users4
  id = (["arn:aws:iam::104836177439:user/miyeon", "arn:aws:iam::104836177439:user/mina"])
}

resource "aws_iam_user" "kpop-users4" {
    name = (["miyeon", "mina"])
    }