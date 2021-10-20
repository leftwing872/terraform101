# EC2

variable "key" {
    type = string
    description = "EC2 Key pairs name"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}
