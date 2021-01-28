# gcp_cloud_dns

A Terraform module that creates a Cloud DNS Zone, and a pair of A record and CName record DNS Record Sets.

## Usage

### Minimal example

```terraform
module "sample_cloud_dns" {
  source = "../modules/cloud_dns"
  name   = "dns-google-apis"

  block_on         = module.tf_gcp_services_apis.service_sleeper
  dns_name         = "googleapis.com."
  network_selflink = "test-network"
  project_id       = "test-project"

  a_record_addresses = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
  a_record_dns_name  = "restricted.googleapis.com."

  cname_record_canonical_name = "restricted.googleapis.com."
  cname_record_dns_name       = "*.googleapis.com."
}
```

### Extended example

```terraform
module "sample_cloud_dns" {
  source = "../modules/cloud_dns"
  name   = "dns-google-apis"

  description      = "DNS Zone to ensure access to googleapis.com via the 'Private Network Access' IPs"
  dns_name         = "googleapis.com."
  network_selflink = "test-network"
  project_id       = "test-project"
  visibility       = "private"

  a_record_addresses = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
  a_record_dns_name  = "restricted.googleapis.com."
  a_record_ttl       = 600

  cname_record_canonical_name = "restricted.googleapis.com."
  cname_record_dns_name       = "*.googleapis.com."
  cname_record_ttl            = 600
}
```

## Input Variables

### Mandatory Variables

| Name                         | Description                                                                             |  Type  |
| :--------------------------- | :-------------------------------------------------------------------------------------- | :----: |
| a_record_addresses           | The list of IP addresses the A record should use.                                       | List   |
| a_record_dns_name            | The DNS name the A record will apply to.                                                | String |
| cname_record_canonical_name" | The Canonical Name for the CName record.                                                | String |
| cname_record_dns_name        | The DNS name the CName record will apply to.                                            | String |
| dns_name                     | The DNS name for the deployed Cloud DNS Zone.                                           | String |
| name                         | The 'user assigned' name for the deployed DNS Zone.                                     | String |
| network_selflink             | The network that should be able to 'see' the deployed DNS Zone.                         | String |
| project_id                   | The ID of the project to deploy into.                                                   | String |

### Optional Variables

| Name             | Description                                                     |  Type  | Default      |
| :--------------- | :-------------------------------------------------------------- | :----: | :----------- |
| a_record_ttl     | The TTL (Time To Live) value (in seconds) for the A record.     | Number | 300          |
| cname_record_ttl | The TTL (Time To Live) value (in seconds) for the CName record. | Number | 300          |
| description      | A description for the deployed DNS zone.                        | String | Empty string |
| visibility       | The visibility of the DNS Zone.                                 | String | private      |

## Outputs

| Name    | Description                      |  Type  |
| :------ | :------------------------------- | :----: |
| zone_id | The ID of the deployed DNS Zone. | String |
