# firewall

Terraform module to configure the firewall for a specified network.

## Usage

### Minimal Example

```terraform
module "gcp_firewall" {
  source       = "../module/firewall_rule"
  name         = "web-ingress-public-https"

  network_name = "my-network"
  project_id   = "my-project-id"
  direction    = "INGRESS"

  allow_rules  = [
    {
      protocol = "TCP",
      ports    = ["443"]
    }
  ]
}
```

### Extended Example

```terraform
module "gcp_firewall" {
  source        = "../module/firewall_rule"
  name          = "web-ingress-public-https"

  network_name   = "my-network"
  project_id     = "my-project-id"
  description    = "My extended HTTPS and SSH firewall rule"
  direction      = "INGRESS"
  priority       = 500
  disabled       = false
  source_ranges  = ["0.0.0.0/0"]
  source_tags    = ["internal"]
  target_tags    = ["accessible"]
  enable_logging = true

  allow_rules   = [
    {
      protocol  = "TCP",
      ports     = ["443"]
    },
    {
      protocol  = "TCP",
      ports     = ["22"]
    }
  ]
}
```

## Input Variables

### Mandatory Variables

| Name           | Description                                                            | Type   |
| -------------- | ---------------------------------------------------------------------- | ------ |
| direction      | Whether this firewall rule applies to INGRESS or EGRESS traffic        | String |
| name           | The name of the firewall                                               | String |
| network_name   | The name of the network to create the firewall on                      | String |
| project_id     | The ID of the project containing the network                           | String |

### Optional Variables

| Name                    | Description                                                                    | Type       | Default                          |
| ----------------------- | ------------------------------------------------------------------------------ | ---------- | -------------------------------- |
| allow_rules             | A list of maps defining the 'allow' rules. See below for map structure         | List [Map] | Empty List                       |
| deny_rules              | A list of maps defining the 'deny' rules. See below for map structure          | List [Map] | Empty List                       |
| description             | A description for this firewall configuration                                  | String     | "AEF Terraform managed firewall" |
| destination_ranges      | The list of destination IP Ranges (in CIDR format) this EGRESS rule applies to | List       | Null                             |
| disabled                | Whether this Firewall configuration should be disabled                         | Bool       | False                            |
| enable_logging          | This field denotes whether to include or exclude metadata for firewall logs    | Bool       | False                            |
| priority                | The network priority that applies to this firewall configuration               | Number     | 1000                             |
| source_ranges           | List of source IP Ranges (in CIDR format) this INGRESS rule applies to         | List       | Null                             |
| source_service_accounts | List of service accounts who can use this INGRESS rule                         | List       | Null                             |
| source_tags             | The source tags that this INGRESS rule should apply to                         | List       | Null                             |
| target_service_accounts | List of service accounts who can use this rule                                 | List       | Null                             |
| target_tags             | A list of instance tags that can use this rule                                 | List       | Null                             |

Note: At least one of 'allow_rules' or 'deny_rules' optional variables should be specified.

Note: If no 'source_ranges', 'source_service_accounts', or 'source_tags' are specified, Google will automatically add a source_range of '0.0.0.0/0'

### 'Rule' Structure

The following structure is used by both 'allow_rules' and 'deny_rules' optional variables.

| Property Name | Description                                                                      | Type          |
| ------------- | -------------------------------------------------------------------------------- | ------------- |
| protocol      | The IP protocol this rule applies to                                             | String        |
| ports         | List of ports this rule applies to - if not specified, rule applies to all ports | List [String] |

## Output Variables

| Name                   | Description                                                | Type   |
| ---------------------- | ---------------------------------------------------------- | ------ |
| firewall_selflink      | self-link to the created firewall                          | String |
