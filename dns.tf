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
# GitHub Pages (A Records at apex + CNAME for blog)
# -----------------------------------------------------------------------------

resource "cloudflare_record" "github_blog" {
  count   = 0 # Set to 1 to enable blog.tech1savvy.me
  zone_id = local.identifiers.cloudflare_zone_id
  name    = "blog"
  content = "tech1savvy.github.io"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "github_apex" {
  for_each = toset([
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ])
  zone_id = local.identifiers.cloudflare_zone_id
  name    = "@"
  content = each.value
  type    = "A"
  ttl     = 1
  proxied = true
}
