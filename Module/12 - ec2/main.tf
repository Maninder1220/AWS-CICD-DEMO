# Creating EC2 for Jenkins Server

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "cicd_server" {
  instance_type = "t2.micro"
  ami = data.aws_ami.ubuntu.id
  key_name = var.public_key                         
  vpc_security_group_ids = [ var.sg_id ]            
  subnet_id = var.public_subnet_id
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install ruby-full -y
    cd /home/ubuntu
    wget https://aws-codedeploy-ap-south-1.s3.amazonaws.com/latest/install
    chmod +x ./install
    sudo ./install auto
    sudo service codedeploy-agent start
    EOF

  tags = {
    Name = "${var.belongs_to}-EC2"
    CodeDeploy   = "MyCdEC2Instance"
    
  }

}