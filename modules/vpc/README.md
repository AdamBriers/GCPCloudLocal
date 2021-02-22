# VPC Module

This module creates a vpc network.

It supports creating:

- A VPC Network

## Usage

Basic usage of this submodule is as follows:

```hcl
module "vpc" {
    source  = "../.."

    project_id   = "<PROJECT ID>"
    network_name = "example-vpc"
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
| [google_compute_network](https://registry.terraform.io/providers/hashicorp/google/3.51/docs/resources/compute_network) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auto\_create\_subnetworks | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | `false` | no |
| delete\_default\_internet\_gateway\_routes | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted | `bool` | `true` | no |
| description | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `""` | no |
| mtu | The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically. | `number` | `0` | no |
| network\_name | The name of the network being created | `any` | n/a | yes |
| project\_id | The ID of the project where this VPC will be created | `any` | n/a | yes |
| routing\_mode | The network routing mode (default 'GLOBAL') | `string` | `"GLOBAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| network | The VPC resource being created |
| network\_name | The name of the VPC being created |
| network\_self\_link | The URI of the VPC being created |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
