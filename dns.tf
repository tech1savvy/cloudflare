data "sops_file" "identifiers" {
  source_file = "identifiers.terraform.json"
}
locals {
  identifiers = jsondecode(data.sops_file.identifiers.raw)
}
#
# =============================================================================
# Cloudflare DNS Records
# =============================================================================

data "cloudflare_zone" "main" {
  zone_id = local.identifiers.cloudflare_zone_id
}

# -----------------------------------------------------------------------------
# World Wide Web (CNAME Record)
# -----------------------------------------------------------------------------

resource "cloudflare_record" "www" {
  zone_id = local.identifiers.cloudflare_zone_id
  name    = "www"
  content = "tech1savvy.me"
  type    = "CNAME"
  ttl     = 1 # Auto TTL when proxied
  proxied = true
}

# -----------------------------------------------------------------------------
# GitHub Pages (CNAME Record)
# -----------------------------------------------------------------------------

resource "cloudflare_record" "github" {
  zone_id = local.identifiers.cloudflare_zone_id
  name    = "github"
  content = "tech1savvy.github.io"
  type    = "CNAME"
  ttl     = 1 # Auto TTL when proxied
  proxied = true
}
