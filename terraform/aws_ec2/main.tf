terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.56"
    }
  }

  backend "s3" {
    bucket = "nix-cfg-terraform-state20241104020325880600000001"
    key = "nix-cfg"
    region = "us-east-2"
    dynamodb_table = "nix-cfg-terraform-state"
    profile = "admin"
  }
}

variable "region" {
  type     = string
  default  = "us-west-2"
  nullable = false
}

variable "instance_name" {
  description = "The name of the instance_name to deploy"
  type        = string
  default     = "builder1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.large"
}

provider "aws" {
  profile = "admin"
  region  = var.region
}

resource "aws_security_group" "main" {
  # The "nixos" Terraform module requires SSH access to the machine to deploy
  # our desired NixOS configuration.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # We will be building our NixOS configuration on the target machine, so we
  # permit all outbound connections so that the build can download any missing
  # dependencies.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow port 80 so that we can view the web server
  # ingress {
  #   from_port = 80
  #   to_port = 80
  #   protocol = "tcp"
  #   cidr_blocks = [ "0.0.0.0/0" ]
  # }
}

# Generate an SSH key pair as strings stored in Terraform state
resource "tls_private_key" "main" {
  algorithm = "ED25519"
}

# Synchronize the SSH private key to a local file that the "nixos" module can
# use
resource "local_sensitive_file" "ssh_private_key" {
  filename = "${path.module}/id_ed25519"
  content  = tls_private_key.main.private_key_openssh
}

resource "local_file" "ssh_public_key" {
  filename = "${path.module}/id_ed25519.pub"
  content  = tls_private_key.main.public_key_openssh
}

# Mirror the SSH public key to EC2 so that we can later install the public key
# as an authorized key for our server
resource "aws_key_pair" "main" {
  public_key = tls_private_key.main.public_key_openssh
}

module "ami" {
  source  = "github.com/Gabriella439/terraform-nixos-ng//ami?ref=af1a0af57287851f957be2b524fcdc008a21d9ae"
  release = "23.05"
  region  = var.region
  system  = "x86_64-linux"
}

resource "aws_instance" "main" {
  # This will be an AMI for a stock NixOS server which we'll get to below.
  ami = module.ami.ami

  instance_type = var.instance_type

  # Install the security groups we defined earlier
  security_groups = [aws_security_group.main.name]

  # Install our SSH public key as an authorized key
  key_name = aws_key_pair.main.key_name

  # Request a bit more space because we will be building on the machine
  root_block_device {
    volume_size = 50
  }
}

# This ensures that the instance is reachable via `ssh` before we deploy NixOS
resource "null_resource" "wait" {
  provisioner "remote-exec" {
    connection {
      host        = aws_instance.main.public_dns
      private_key = tls_private_key.main.private_key_openssh
    }

    inline = [":"] # Do nothing; we're just testing SSH connectivity
  }
}

module "nixos" {
  source      = "github.com/Gabriella439/terraform-nixos-ng//nixos?ref=af1a0af57287851f957be2b524fcdc008a21d9ae"
  host        = "root@${aws_instance.main.public_ip}"
  flake       = ".#builder1"
  # arguments   = ["--build-host", "root@${aws_instance.main.public_ip}"]
  ssh_options = "-o StrictHostKeyChecking=accept-new -i ${local_sensitive_file.ssh_private_key.filename}"
  depends_on  = [null_resource.wait]
}

output "public_dns" {
  value = aws_instance.main.public_dns
}
