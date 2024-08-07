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
  region = "eu-west-1"
}

terraform { 
  cloud { 
    
    organization = "NimbusOne" 

    workspaces { 
      name = "WEB-3TIER-DEV" 
    } 
  } 
}