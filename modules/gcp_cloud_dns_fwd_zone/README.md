# gcp_cloud_dns_fwd_zone

A Terraform module that creates a Cloud DNS Foward Zone, forwarding requests for particular domains to the specified nameservers.

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

### Minimal example

```terraform
module "sample_cloud_dns_fwd_onprem" {
  source = "../modules/gcp_cloud_dns_fwd"

  private_visibility_config_networks = ["${dependency.vpc_shared_prd.outputs.network_self_link}"]
  description                        = "DNS Zone to forward requests to on-prem nameservers"
  project_id                         = "test-project"
  name                               = "dns-google-fwd"
  dns_name                           = "group.net."
  target_name_server_addresses       = ["10.9.10.1", "10.9.10.2"]
}
```

## Input Variables

### Mandatory Variables

| Name                         | Description                                                                             |  Type  |
| :--------------------------- | :-------------------------------------------------------------------------------------- | :----: |
| dns_name                     | The DNS name for the deployed Cloud DNS Zone.                                           | String |
| name                         | The 'user assigned' name for the deployed DNS Zone.                                     | String |
| private_visibility_config_networks | The network that should be able to 'see' the deployed DNS Zone.                   | String |
| project_id                   | The ID of the project to deploy into.                                                   | String |
| target_name_server_addresses | The NameServer IP Address/s                                                             | List   |

### Optional Variables

| Name             | Description                                                     |  Type  | Default      |
| :--------------- | :-------------------------------------------------------------- | :----: | :----------- |
| description      | A description for the deployed DNS zone.                        | String | Empty string |
| visibility       | The visibility of the DNS Zone.                                 | String | private      |


## Outputs

| Name    | Description                      |  Type  |
| :------ | :------------------------------- | :----: |
| zone_id | The ID of the deployed DNS Zone. | String |
