output "website_url" {
  description = "Akses website lewat URL ini"
  value       = "http://${module.compute.alb_dns_name}"
}