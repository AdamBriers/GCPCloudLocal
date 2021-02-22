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
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.2 |
| google | ~> 3.51 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.51 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [google_compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/3.51/docs/resources/compute_subnetwork) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The ID of the Shared VPC Host project in which this subnetwork belongs | `any` | n/a | yes |
| subnets | List of subnets being created in this VPC | `list(map(string))` | `[]` | no |
| vpc\_network\_name | The name (ID) of the VPC with which this subnetwork should be linked | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| subnet\_ids | The created subnets resources |
| subnets | The created subnets resources |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
