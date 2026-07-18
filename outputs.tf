output "id" {
  description = "Identifier of the firewall rule."
  value       = google_compute_firewall.this.id
}

output "self_link" {
  description = "URI of the firewall rule."
  value       = google_compute_firewall.this.self_link
}

output "name" {
  description = "Name of the firewall rule."
  value       = google_compute_firewall.this.name
}
