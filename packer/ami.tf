data "aws_ami" "ami" {
  most_recent = true
  owners = ["self"]
  filter {
    name = "name"
    values = ["packer-with-docker-ubuntu-ami"]
  }
}

output "ami_id" {
  value = data.aws_ami.ami.id
}

# ami-0eb5cbeafda02c2e5
resource "aws_instance" "packer" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  key_name = "id_rsa"

  lifecycle {
    ignore_changes = [ ami ]
  }
}

provider "aws" {
  region = "us-east-2"
}