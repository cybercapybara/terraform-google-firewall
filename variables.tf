variable "project_id" {
  description = "ID of the project in which to create the firewall rule."
  type        = string
}

variable "name" {
  description = "Name of the firewall rule."
  type        = string
}

variable "network" {
  description = "Self link or name of the VPC network the rule applies to."
  type        = string
}

variable "direction" {
  description = "Direction of traffic the rule applies to: INGRESS or EGRESS."
  type        = string
  default     = "INGRESS"

  validation {
    condition     = contains(["INGRESS", "EGRESS"], var.direction)
    error_message = "direction must be either INGRESS or EGRESS."
  }
}

variable "priority" {
  description = "Priority of the rule, between 0 and 65535. Lower values take precedence."
  type        = number
  default     = 1000

  validation {
    condition     = var.priority >= 0 && var.priority <= 65535
    error_message = "priority must be between 0 and 65535."
  }
}

variable "allow" {
  description = "Allow rules, mapping IP protocol (e.g. tcp) to a list of ports. Ports may be empty for all ports."
  type        = map(list(string))
  default     = {}
}

variable "deny" {
  description = "Deny rules, mapping IP protocol to a list of ports."
  type        = map(list(string))
  default     = {}
}

variable "source_ranges" {
  description = "Source CIDR ranges for INGRESS rules."
  type        = list(string)
  default     = []
}

variable "destination_ranges" {
  description = "Destination CIDR ranges for EGRESS rules."
  type        = list(string)
  default     = []
}

variable "target_tags" {
  description = "Instance network tags the rule applies to. Empty applies to all instances in the network."
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Optional description for the firewall rule."
  type        = string
  default     = null
}
