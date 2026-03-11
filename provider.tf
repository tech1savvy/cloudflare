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
  required_version = ">= 1.5.7"
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
