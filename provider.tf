ephemeral "sops_file" "secrets" {
  source_file = "secrets.terraform.json"
}

locals {
  secrets = jsondecode(ephemeral.sops_file.secrets.raw)
}

provider "cloudflare" {
  api_token = local.secrets.cloudflare_api_token
}

terraform {
  backend "s3" {
    bucket       = "tech1savvy-terraform-state"
    key          = "cloudflare/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }

  required_version = ">= 1.14.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~> 1.4.0"
    }
  }
}
