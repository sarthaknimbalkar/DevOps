terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.aws_region
  alias   = "main"
}

resource "aws_instance" "app_server" {
  provider      = aws.main
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name        = "Terraform_Demo"
    Environment = "Development"
  }
}

output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance."
  value       = aws_instance.app_server.public_ip
}
