data "aws_ami" "amzlinux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"]
}

module "bastion_host" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.0.2"

  name = "${var.project_name}-bastion-host"

  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.bastion_host_instance_type
  key_name      = var.bastion_host_instance_key_name

  vpc_security_group_ids = [var.sg.bastion_host_sg]
  subnet_id              = var.vpc.public_subnets[0]


  tags = {
    Name    = "${var.project_name}-bastion-host"
    Project = var.project_name
  }
}
