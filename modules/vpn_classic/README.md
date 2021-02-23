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

| Name |
|------|
| [google_compute_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) |
| [google_compute_route](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_route) |
| [google_compute_vpn_gateway](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_vpn_gateway) |
| [google_compute_forwarding_rule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule)|
| [google-beta_google_compute_vpn_tunnel](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_vpn_tunnel) |
| [google-beta_google_secret_manager_secret_version](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/data-sources/google_secret_manager_secret_version) |
| [google_project_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) |
| [google_secret_manager_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | VPN gateway name, and prefix used for dependent resources. | `string` | n/a | yes |
| network | VPC used for the gateway and routes. | `string` | n/a | yes |
| gateway_name | The name of VPN gateway. | `string` | `azure_vpn` | yes |
| ip_name | The name of gateway IP | `string` | `azure-vpn-ip` | | no |
| project\_id | Project where resources will be created. | `string` | n/a | yes |
| region | Region used for resources. | `string` | n/a | yes |
| secret\_id | Unique ID for the secret in GCP secret manger. | `string` | n/a | yes |
| tunnel_count | The number of tunnels from each VPN gw. | `Number` | 1 | no |
| tunnel_name_prefix | The optional custom name of VPN tunnel being created | `string` | "" | no |
| local_traffic_selector | Local traffic selector to use when establishing the VPN tunnel with peer VPN gateway. | `list(string)` | 0.0.0.0/0 | no |
| remote_traffic_selector | Local traffic selector to use when establishing the VPN tunnel with peer VPN gateway. | `list(string)` | 0.0.0.0/0 | no |
| remote_subnet | remote subnet ip range in CIDR format - x.x.x.x/x | `list(string)` | [] | no |
| route_priority | Priority for static route being created | `Number` | 1000 | no |
| ike_version | The IKE version used by this tunnel | `Number` | 2 | no |
| cr_name | The name of cloud router for BGP routing | `string` | "" | no |
| cr_enabled | If there is a cloud router for BGP routing | `bool` | false | no |

## Outputs

| Name | Description |
|------|-------------|
| gateway | VPN gateway resource. |
| vpn_gw_name | VPN gateway name. |
| vpn_gw_self_link | VPN gateway self link. |
| vpn_gw_ip_self_link | VPN IP self link. |
| vpn_tunnels_names-static | VPN tunnel names. |
| vpn_tunnels_self_link-static | VPN tunnel self links. |
| vpn_tunnels_id | VPN tunnel resources. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
