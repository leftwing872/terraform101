
variable "s3bucket_name" {
    type = string
    description = "s3 bucket name"
    default = "examplecorp-tfstate-yourid"
}


variable "ddb_name" {
  description = "Dynamodb name"
  type        = string
  default     = "examplecorp-andromeda-qa-front_service-terraform-lock"
}
