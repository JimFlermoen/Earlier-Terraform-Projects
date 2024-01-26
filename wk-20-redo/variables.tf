# ---Root/Variables.tf ---

variable "vpc_id" {
  description = "Default vpc id"
  type        = string
  default     = "vpc-0ee939e20d8876635"
}

variable "ami_id" {
  description = "Ubuntu Ami id"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  description = "instance_type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "us-east-1a subnet id"
  type        = string
  default     = "subnet-048ec70282649b284"
}

