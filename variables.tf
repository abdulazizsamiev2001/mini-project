variable "ingress_ports" {
  type    = list(any)
  default = [22, 80, 443]
}

variable "egress_ports" {
  type    = list(any)
  default = [8000, 8080, 8888]
}

variable "ami" {
  type = map(string)

  default = {
    us-east-1 = "ami-087c17d1fe0178315"
    us-east-2 = "ami-00dfe2c7ce89a450b"
    us-west-1 = "ami-011996ff98de391d1"
    us-west-2 = "ami-0c2d06d50ce30b442"
  }
}

variable "instance_type" {
  type = list(string)

  default = ["t2.micro", "t2.nano", "t2.large"]
}