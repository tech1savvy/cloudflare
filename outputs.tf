
# =============================================================================
# Outputs
# =============================================================================

output "zone_name" {
  description = "The domain name managed by this configuration"
  value       = data.cloudflare_zone.main.name
}

output "github_record_hostname" {
  description = "GitHub Pages hostname"
  value       = cloudflare_record.github.hostname
}
