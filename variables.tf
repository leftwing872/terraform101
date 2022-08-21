# EC2

variable "vpc_id" {
    type = string
    description = "VPC id"
}

variable "key" {
    type = string
    description = "EC2 Key pairs name"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}


variable "ami_id" {
    type = string
    default = "ami-01711d925a1e4cc3a"
    description = "ami id"
}
