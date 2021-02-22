# gcp_cloud_dns

A Terraform module that creates a Cloud DNS Zone, and a pair of A record and CName record DNS Record Sets.

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
### Example

```terraform
module "sample_cloud_dns" {
  source = "../modules/cloud_dns"

  name                               = "private-google-apis-dns"
  project_id                         = dependency.vpc_host_project.outputs.project_id
  private_visibility_config_networks = ["${dependency.vpc_shared_prd.outputs.network_self_link}", "${dependency.vpc_shared_dev.outputs.network_self_link}"]
  description                        = "DNS Zone to ensure access to googleapis.com via the 'Private Network Access' IPs"
  dns_name                           = "googleapis.com."
  description                        = "Private DNS zone for googleapis.com"
  recordsets = [
    {
      name    = "restricted"
      type    = "A"
      ttl     = 300
      records = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
    },
    {
      name    = "*"
      type    = "CNAME"
      ttl     = 300
      records = ["restricted.googleapis.com."]
    }
  ]
}
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
| recordsets                   | Records to add to the zone.                                                             | List(object) |

### Optional Variables

| Name             | Description                                                     |  Type  | Default      |
| :--------------- | :-------------------------------------------------------------- | :----: | :----------- |
| description      | A description for the deployed DNS zone.                        | String | Empty string |
| visibility       | The visibility of the DNS Zone.                                 | String | private      |

## Outputs

| Name    | Description                      |  Type  |
| :------ | :------------------------------- | :----: |
| zone_id | The ID of the deployed DNS Zone. | String |

## References

### Terraform

[Cloud DNS Managed Zone](https://www.terraform.io/docs/providers/google/r/dns_managed_zone.html)

[Cloud DNS Record Set](https://www.terraform.io/docs/providers/google/r/dns_record_set.html)

### Google Cloud Platform

[Google Cloud DNS](https://cloud.google.com/dns)
