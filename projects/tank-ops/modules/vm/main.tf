resource "aws_instance" "main" {
  instance_type = var.ec2_type
  # subnet_id     = var.public_subnet_ids[0]

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

resource "aws_eip_association" "main" {
  instance_id = aws_instance.main.id
}
