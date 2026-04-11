# =============================================================================
# Outputs
# =============================================================================

output "zone_name" {
  description = "The domain name managed by this configuration"
  value       = data.cloudflare_zone.main.name
}

output "github_record_hostname" {
  description = "GitHub Pages hostname"
  value       = length(cloudflare_record.github_blog) > 0 ? cloudflare_record.github_blog[0].hostname : null
}
