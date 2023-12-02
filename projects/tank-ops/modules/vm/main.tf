data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "main" {
  instance_type = var.ec2_type
  ami           = data.aws_ami.ubuntu.id
  subnet_id     = var.public_subnet_ids[0]

  network_interface {
    network_interface_id = var.ec2_nic_id
    device_index         = 0
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io docker-compose
    git clone https://github.com/Fugazzii/tank-ops ./tank-ops
    cd ./tank-ops
    sudo docker-compose up --build -V
  EOF

  tags = {
    Description = "Main EC2 instance"
  }

  lifecycle {
    prevent_destroy = false
  }
}
