# terraform-google-firewall

Terraform module that manages a [Google Cloud](https://cloud.google.com/)
VPC firewall rule (`google_compute_firewall`). It supports ingress or egress
direction with allow and deny blocks driven by simple protocol-to-ports maps.

## Usage

```hcl
module "firewall" {
  source = "github.com/cybercapybara/terraform-google-firewall"

  project_id = var.project_id
  name       = "allow-ssh"
  network    = module.vpc.self_link
  direction  = "INGRESS"

  allow = {
    tcp = ["22"]
  }

  source_ranges = ["10.0.0.0/8"]
  target_tags   = ["ssh"]
}
```

A runnable example lives in [`examples/basic`](examples/basic).

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | >= 1.5   |
| google    | >= 5.0   |

## Inputs

| Name                 | Description                                                       | Type                | Default       | Required |
|----------------------|-------------------------------------------------------------------|---------------------|---------------|:--------:|
| `project_id`         | ID of the project in which to create the firewall rule.           | `string`            | n/a           |   yes    |
| `name`               | Name of the firewall rule.                                        | `string`            | n/a           |   yes    |
| `network`            | Self link or name of the VPC network.                             | `string`            | n/a           |   yes    |
| `direction`          | Direction of traffic: INGRESS or EGRESS.                          | `string`            | `"INGRESS"`   |    no    |
| `priority`           | Priority of the rule, 0-65535.                                    | `number`            | `1000`        |    no    |
| `allow`              | Allow rules mapping protocol to ports.                            | `map(list(string))` | `{}`          |    no    |
| `deny`               | Deny rules mapping protocol to ports.                             | `map(list(string))` | `{}`          |    no    |
| `source_ranges`      | Source CIDR ranges for INGRESS rules.                             | `list(string)`      | `[]`          |    no    |
| `destination_ranges` | Destination CIDR ranges for EGRESS rules.                         | `list(string)`      | `[]`          |    no    |
| `target_tags`        | Instance network tags the rule applies to.                       | `list(string)`      | `[]`          |    no    |
| `description`        | Optional description for the firewall rule.                      | `string`            | `null`        |    no    |

## Outputs

| Name        | Description                          |
|-------------|--------------------------------------|
| `id`        | Identifier of the firewall rule.    |
| `self_link` | URI of the firewall rule.           |
| `name`      | Name of the firewall rule.          |

## License

[MIT](LICENSE)
