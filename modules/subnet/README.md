# VPC Module

This module creates a vpc network.

It supports creating:

- A VPC Network

## Usage

Basic usage of this submodule is as follows:

```hcl
module "vpc" {
    source  = "../.."

    ip_cidr_range           = "<IP_CIDR_RANGE>"
    project_id              = "shared-vpc-host-project-id"
    region                  = "example-region"
    sub_network_name        = "example-subnetwork"
    sub_network_description = "example-subnetwork-description"
    vpc_network_name        = "vpc-network-name"

}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ip\_cidr\_range | The CIDR range for this subnetwork | `string` | n/a | yes |
| private\_ip\_google\_access | Enables VMs in this subnetwork without external IP addresses to access Google APIs and services by using Private Google Access | `bool` | `false` | no |
| project\_id | The ID of the Shared VPC Host project in which this subnetwork belongs | `string` | n/a | yes |
| region | The Region in which this subnetwork should be created | `string` | n/a | yes |
| sub\_network\_description | The description of this subnetwork being created | `string` | n/a | yes |
| sub\_network\_name | The name of this subnetwork | `string` | n/a | yes |
| vpc\_network\_name | The name (ID) of the VPC with which this subnetwork should be linked | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| creation\_timestamp | Creation timestamp in RFC3339 text format |
| gateway\_address | The gateway address for default routes to reach destination addresses outside this subnetwork |
| sub\_network\_id | The subnetwork resource being created |
| sub\_network\_self\_link | The URI of the subnetwork being created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
