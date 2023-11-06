terraform {
    backend "s3" { 
      bucket         = "examplecorp-tfstate-yourid" # s3 bucket 이름
      key            = "terraform/own-your-path/terraform.tfstate" # s3 내에서 저장되는 경로를 의미합니다.
      region         = "ap-northeast-2"  
      encrypt        = false
      dynamodb_table = "examplecorp-andromeda-qa-front_service-terraform-lock" ##DDB table 이름
    }
}

