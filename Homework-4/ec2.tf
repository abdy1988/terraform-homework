resource "aws_instance" "web" {
  ami           = var.ec2_web["ami_id"]
  instance_type = var.ec2_web["type"]
  subnet_id = var.ec2_web["subnet"]
  tags = local.common_tags
}
