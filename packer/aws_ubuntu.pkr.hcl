packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-with-docker-ubuntu-ami"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami_filter {
    filters = {
      name  = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"

    }
    most_recent = true
    owners  = ["099720109477"]
  }
  ssh_username = "ubuntu"
}
build {
  name = "ansible-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    script = "./docker.sh"
  }
}