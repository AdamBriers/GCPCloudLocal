# Network Peering

This module allows creation of a [VPC Network Peering](https://cloud.google.com/vpc/docs/vpc-peering) between two networks.

The resources created/managed by this module are:

- one part of the network peering from `local network` to `peer network`
- one network peering from `peer network` to `local network`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| export\_custom\_routes | Export custom routes to / from peer network. | `bool` | `false` | no |
| export\_custom\_routes | Export custom routes to / from peer network. | `bool` | `false` | no |
| name | Name for the first network to add a peering to. | `string` | n/a | yes |
| name_second | Name for the second network to to which the first should be peered. | `string` | n/a | yes |
| network | Resource link of the first network to add a peering to. | `string` | n/a | yes |
| peer\_network | Resource link of the second / peer network. | `string` | n/a | yes |
| export\_custom\_routes | Whether to export the custom routes to / from the networks in the peering | `bool` | `false` | no |
| import\_custom\_routes | Whether to import the custom routes to / from the networks in the peering | `bool` | `false` | no |
| export\_subnet\_routes\_with\_public\_ip | Whether subnet routes with public IP range are exported | `bool` | `false` | no |
import\_subnet\_routes\_with\_public\_ip | Whether subnet routes with public IP range are imported | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| peer\_id\_first | An identifier for the first network resource with format {{network}}/{{name}}. |
| peer\_state\_first | State for the first network peering, either ACTIVE or INACTIVE. The peering is ACTIVE when there's a matching configuration in the peer network. |
| state\_details\_first | Details about the current state of the first network peering. |
| peer\_id\_second | An identifier for the second network resource with format {{network}}/{{name}}. |
| peer\_state\_second | State for the first second peering, either ACTIVE or INACTIVE. The peering is ACTIVE when there's a matching configuration in the peer network. |
| state\_details\_second | Details about the current state of the second network peering. |

