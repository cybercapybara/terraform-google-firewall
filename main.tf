resource "google_compute_firewall" "this" {
  project     = var.project_id
  name        = var.name
  network     = var.network
  direction   = var.direction
  priority    = var.priority
  description = var.description

  source_ranges      = length(var.source_ranges) > 0 ? var.source_ranges : null
  destination_ranges = length(var.destination_ranges) > 0 ? var.destination_ranges : null
  target_tags        = length(var.target_tags) > 0 ? var.target_tags : null

  dynamic "allow" {
    for_each = var.allow
    content {
      protocol = allow.key
      ports    = allow.value
    }
  }

  dynamic "deny" {
    for_each = var.deny
    content {
      protocol = deny.key
      ports    = deny.value
    }
  }
}
