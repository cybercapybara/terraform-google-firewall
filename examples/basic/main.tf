terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "example" {
  project                 = var.project_id
  name                    = "example-fw-network"
  auto_create_subnetworks = false
}

module "firewall" {
  source = "../.."

  project_id = var.project_id
  name       = "example-allow-ssh"
  network    = google_compute_network.example.self_link
  direction  = "INGRESS"

  allow = {
    tcp = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

variable "project_id" {
  description = "Project ID to deploy the example firewall rule into."
  type        = string
}

variable "region" {
  description = "Region for the google provider."
  type        = string
  default     = "us-central1"
}

output "firewall_id" {
  value = module.firewall.id
}
