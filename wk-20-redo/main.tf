# ---Root/Main.tf ---

# --- Create EC2 Instance ---

resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  key_name                    = aws_key_pair.generated.key_name
  user_data                   = file("jenkins.sh")
  security_groups             = [aws_security_group.wk_20_redo.id]

  tags = {
    Name = "Jenkins"
  }
}

# --- Create private key ---
resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

# --- Store Private Key in local file 
resource "local_file" "private_key_pem" {
  content  = tls_private_key.generated.private_key_pem
  filename = "MyAWSKey.pem"
}

# --- Create Public Key
resource "aws_key_pair" "generated" {
  key_name   = "MyAWSKey"
  public_key = tls_private_key.generated.public_key_openssh
}

# --- Create Security Group ---
resource "aws_security_group" "wk_20_redo" {
  name   = "wk_20_redo_sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow ssh from my ip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # input my ip address
  }

  ingress {
    description = "incoming Jenkins port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wk_20_redo_sg"
  }
}

# --- Create s3 bucket ---
resource "aws_s3_bucket" "jenkins_artifacts" {
  bucket = random_id.s3.hex
}

# --- Random resource for s3 bucket name ---
resource "random_id" "s3" {
  byte_length = 8
} 

