# firewall

Terraform module to configure the firewall for a specified network.
This module uses a `for_each` loop `firewall_rules`. The definition of the rule is set through a map where keys are rule names, and values rule as per the examples below.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| google | ~> 3.51.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.51.0 |

## Usage

### Minimal Example

```terraform
module "gcp_firewall" {
  source       = "../module/firewall_rule"

  project_id     = "test-project-1234"
  network        = dependency.vpc_network.outputs.network_self_link
  enable_logging = false
  firewall_rules = {
    all-ingress-firewall-name = {
      description          = "INGRESS firewall for all ports and protocol from production to test and dev."
      direction            = "INGRESS"
      action               = "allow"
      ranges               = ["172.26.0.0/18"]
      sources              = []
      targets              = []
      use_service_accounts = false
      rules = [
        {
          protocol = "all"
          ports    = []
        }
      ]
      extra_attributes = {}
    }
```

### Extended Example (multiple firewalls)

```terraform
module "gcp_firewall" {
  source        = "../module/firewall_rule"
  
project_id     = "test-project-1234"
  network        = dependency.vpc_network.outputs.network_self_link
  enable_logging = false

  firewall_rules = {
    ssh-ingress-firewall-name = {
      description          = "INGRESS firewall for ssh access."
      direction            = "INGRESS"
      action               = "allow"
      ranges               = ["172.26.0.0/18"]
      sources              = []
      targets              = []
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
      extra_attributes = {}
    },
  all-egress-deny = {
      description          = "EGREE rule to deny all"
      direction            = "EGRESS"
      action               = "deny"
      ranges               = ["0.0.0.0/0"]
      sources              = ["bar"]
      targets              = ["foo"]
      use_service_accounts = false
      rules = [
        {
          protocol = "all"
          ports    = []
        }
      ]
      extra_attributes = {
        priority = 500
        disabled = true
      }
    },
```

## Input Variables

### Mandatory Variables

| Name           | Description                                                             | Type   |
| -------------- | ----------------------------------------------------------------------- | ------ |
| direction      | Whether this firewall rule applies to INGRESS or EGRESS traffic.        | String |
| name           | The name of the firewall.                                               | String |
| network_name   | The name of the network to create the firewall on.                      | String |
| project_id     | The ID of the project containing the network.                           | String |
| firewall_rules | List of custom firewall rule definitions.                               |<pre>map(object({<br>    description          = string<br>    direction            = string<br>    action               = string # (allow\|deny)<br>    ranges               = list(string)<br>    sources              = list(string)<br>    targets              = list(string)<br>    use_service_accounts = bool<br>    rules = list(object({<br>      protocol = string<br>      ports    = list(string)<br>    }))<br>    extra_attributes = map(string)<br>  }))</pre>|


Note: If no 'source_ranges', 'source_service_accounts', or 'source_tags' are specified, Google will automatically add a source_range of '0.0.0.0/0'

## Output Variables

| Name                       | Description                                                | Type   |
| -------------------------- | ---------------------------------------------------------- | ------ |
| custom_ingress_allow_rules | Custom ingress rules with allow blocks.
| custom_ingress_deny_rules  | Custom ingress rules with deny blocks.
| custom_egress_allow_rules  | Custom egress rules with allow blocks.
| custom_egress_deny_rules   | Custom egress rules with deny blocks.
## References

### Terraform

[GCP Compute Firewall](https://www.terraform.io/docs/providers/google/r/compute_firewall.html)

### Google Cloud Platform

[GCP Compute Firewall](https://cloud.google.com/vpc/docs/firewalls)
