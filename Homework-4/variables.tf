variable region {
  default = "us-east-1"
  type = string
  description = "Provide region"
}

variable key_name {
  default = "my-key"
  type = string
  description = "Provide key name"
}

variable port {
  default = [22, 80, 443, 3306]
  type = list(number)
  description = "Provide port"
}

variable ec2_web {
  default = {
    ami_id = "ami-08a6efd148b1f7504"
    type = "t2.micro"
    subnet = "subnet-0110d2e5573f05f89"
  }
  type = map(string)
}