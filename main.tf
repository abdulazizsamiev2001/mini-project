resource "aws_key_pair" "my-key" {
  key_name   = "devops14_2021"
  public_key = file("${path.module}/key.txt")
}

resource "aws_eip" "devops14_2021" {
  vpc = true
  tags = {
    "Name"  = "devops14_2021"
    "Owner" = "Abdulaziz"
  }
}

output "public_ip" {
  value = aws_eip.devops14_2021.public_ip
}

resource "aws_security_group" "devops14_2021" {
  name = "devops14_2021"
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = var.egress_ports
    #    iterator = port
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_instance" "devops14_2021" {
  ami = var.ami["us-west-1"]
  instance_type = var.instance_type[0]
  key_name      = aws_key_pair.my-key.key_name
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id = aws_security_group.devops14_2021.id
  network_interface_id = aws_instance.devops14_2021.primary_network_interface_id
}