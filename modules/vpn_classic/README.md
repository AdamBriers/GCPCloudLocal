# vpn_classic
This module creates a GCP classic VPN.
Creates the VPN gateway, the specified policy based tunnels and the forwarding rules.
Other optional variables include creating the routes that will use the tunnel hop and use of a router if required (Route names will be prefixed from the gateway name).

# Secret Manager
This module has been updated to incorporate the use of the tunnel PSK being retrieved from Google Secret Manager, instead of using a randomly generated PSK.
The code has been commented out but can be reverted if required.

The `secret_id` is an input in what to call the secret resource, not the actual PSK. That can be entered in the Secret Manager in the GCP Console.


## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Examples

```hcl
module "vpn_classic" {
  source = "modules/vpn_classic"

  project_id              = "gc-p-prj-myproject-0002"
  gateway_name            = "gc-a-vpnclassic-0001"
  secret_id               = "gc-a-sct-supersecret-0001"
  ip_name                 = "gc-a-vpnextip-0001"
  network                 = "https://www.googleapis.com/compute/v1/projects/<PROJECT_ID>/global/networks/network-1"
  region                  = "europe-west2"
  tunnel_count            = 1
  peer_ips                = ["8.8.8.8"]
  route_priority          = 1000
  local_traffic_selector  = ["172.26.64.0/23", "172.26.66.0/23", "172.26.68.0/23", "172.26.0.0/23", "199.36.153.4/30"]
  remote_traffic_selector = ["172.20.0.0/16", "172.30.0.0/16"]
}
```
## Extended Example

```hcl
module "vpn_classic" {
  source = "modules/vpn_classic"

  project_id              = "gc-p-prj-myproject-0002"
  gateway_name            = "gc-a-vpnclassic-0001"
  secret_id               = "gc-a-sct-supersecret-0001"
  ip_name                 = "gc-a-vpnextip-0001"
  network                 = "https://www.googleapis.com/compute/v1/projects/<PROJECT_ID>/global/networks/network-1"
  region                  = "europe-west2"
  tunnel_count            = 2
  peer_ips                = ["8.8.8.8", "4.4.4.4"]
  route_priority          = 1000
  local_traffic_selector  = ["172.26.64.0/23", "172.26.66.0/23", "172.26.68.0/23", "172.26.0.0/23", "199.36.153.4/30"]
  remote_traffic_selector = ["172.20.0.0/16", "172.30.0.0/16"]
  remote_subnet           = ["172.20.0.0/16", "172.30.0.0/16"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| google-beta | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [google-beta_google_secret_manager_secret_version](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/data-sources/google_secret_manager_secret_version) |
| [google_compute_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) |
| [google_compute_forwarding_rule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule) |
| [google_compute_route](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) |
| [google_compute_vpn_gateway](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_vpn_gateway) |
| [google_compute_vpn_tunnel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_vpn_tunnel) |
| [google_project_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) |
| [google_secret_manager_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cr\_enabled | If there is a cloud router for BGP routing | `bool` | `false` | no |
| cr\_name | The name of cloud router for BGP routing | `string` | `""` | no |
| gateway\_name | The name of VPN gateway | `string` | `"azure-vpn"` | no |
| ike\_version | Please enter the IKE version used by this tunnel (default is IKEv2) | `number` | `2` | no |
| ip\_name | The name of gateway IP | `string` | `"azure-vpn-ip"` | no |
| local\_traffic\_selector | Local traffic selector to use when establishing the VPN tunnel with peer VPN gateway.<br>Value should be list of CIDR formatted strings and ranges should be disjoint. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| network | The name of VPC being created | `string` | n/a | yes |
| peer\_ips | IP address of remote-peer/gateway | `list(string)` | n/a | yes |
| project\_id | The ID of the project where this VPC will be created | `string` | n/a | yes |
| region | The region in which you want to create the VPN gateway | `string` | n/a | yes |
| remote\_subnet | remote subnet ip range in CIDR format - x.x.x.x/x | `list(string)` | `[]` | no |
| remote\_traffic\_selector | Remote traffic selector to use when establishing the VPN tunnel with peer VPN gateway.<br>Value should be list of CIDR formatted strings and ranges should be disjoint. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| route\_priority | Priority for static route being created | `number` | `1000` | no |
| secret\_id | Unique ID for the secret in GCP secret manger. | `string` | n/a | yes |
| tunnel\_count | The number of tunnels from each VPN gw (default is 1) | `number` | `1` | no |
| tunnel\_name\_prefix | The optional custom name of VPN tunnel being created | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| gateway | VPN gateway resource. |
| vpn\_gw\_ip\_self\_link | VPN IP self link. |
| vpn\_gw\_name | VPN gateway name. |
| vpn\_gw\_self\_link | VPN gateway self link. |
| vpn\_tunnels\_id | The VPN tunnel ID |
| vpn\_tunnels\_names-static | The VPN tunnel name is |
| vpn\_tunnels\_self\_link-static | The VPN tunnel self-link is |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
