# cloud_nat

Configures Cloud Router, if required on the supplied network, and then enables Cloud NAT for that network.

The `name` input creates the Cloud NAT and creates a Cloud Router using the same name. Adding the input `router_name` attaches the Cloud NAT to an existing Cloud Router.

## Usage

### Minimal example (Cloud Router not already created)

```terraform
module "cloud_nat" {
  source = "modules/cloud_nat"

  project_id       = "gc-r-prj-datatest-0001-1977"
  name             = "gc-r-nat-0001"
  network_selflink = "fh-tf-test-vpc"
}
```

### Extended example (Adding the router_name of the already existing Cloud Router)

```terraform
module "cloud_nat" {
  source = "modules/cloud_nat"

  router_name      = module.vpn_ha.router_name
  project_id       = "gc-r-prj-datatest-0001-1977"
  name             = "gc-r-nat-0001"
  network_selflink = "fh-tf-test-vpc"
  enable_logs      = true
  log_filter_level = "ERRORS_ONLY"
  router_asn       = 12345

  nat_ip_allocate_option         = "AUTO_ONLY"
  source_subnet_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
```

## Input Variables

### Mandatory Variables

| Name             | Description                                        |  Type  |
| :--------------- | :------------------------------------------------- | :----: |
| name             | "Name of the cloud nat. Will also name the router if creating one. | String |
| project_id       | The if of the project containing the network.      | String |

### Optional Variables

| Name                           | Description                                                      |  Type  | Default                       |
| :----------------------------- | :--------------------------------------------------------------- | :----: | :---------------------------- |
| enable_logs                    | Whether logging should be enabled.                               | Bool   | true                          |
| log_filter_level               | The desired filtering of logs from this Cloud NAT instance.      | String | ALL                           |
| nat_ip_allocation_option       | How external IPs should be allocated for this Cloud NAT.         | String | AUTO_ONLY                     |
| region                         | The region the underlying Cloud Router should be deployed to.    | String | europe-west2                  |
| router_asn                     | The ASN to be used by the router.                                | Number | 64514                         |
| router_name                    | Name of router to attach to. If left empty, will create a router | String | Emtpy string                  |
| source_subnet_ip_ranges_to_nat | How the Cloud NAT should be configured per Subnetwork.           | String | ALL_SUBNETWORKS_ALL_IP_RANGES |

## Outputs

| Name        | Description                             |  Type  |
| :---------- | :-------------------------------------- | :----: |
| nat_id      | The ID of the created Cloud NAT.        | String |
| router      | Router resource (only if auto-created). | String |
| router_name | Router name.                            | String |
