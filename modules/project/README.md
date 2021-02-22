# Project

- Allows creation and management of a Google Cloud Platform project: https://www.terraform.io/docs/providers/google/r/google_project.html

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
| random | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [google_compute_shared_vpc_host_project](https://registry.terraform.io/providers/hashicorp/google/3.51/docs/resources/compute_shared_vpc_host_project) |
| [google_compute_shared_vpc_service_project](https://registry.terraform.io/providers/hashicorp/google/3.51/docs/resources/compute_shared_vpc_service_project) |
| [google_project](https://registry.terraform.io/providers/hashicorp/google/3.51/docs/resources/project) |
| [google_project_iam_audit_config](https://registry.terraform.io/providers/hashicorp/google/3.51/docs/resources/project_iam_audit_config) |
| [google_project_service](https://registry.terraform.io/providers/hashicorp/google/3.51/docs/resources/project_service) |
| [random_integer](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account | The ID of the billing account this project belongs to | `string` | n/a | yes |
| disable\_dependent\_services | Whether services that are enabled and which depend on this service should also be disabled when this service is destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_dependent_services | `bool` | `true` | no |
| disable\_on\_destroy | Whether project services will be disabled when the resources are destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_on_destroy | `bool` | `true` | no |
| folder\_id | The ID of the folder this project should be created under.<br>  Only one of org\_id or folder\_id may be specified. <br>  If the org\_id is specified then the project is created at the top level.<br>  If the folder\_id is specified, then the project is created under the specified folder. | `string` | `""` | no |
| host\_project\_id | The Host project id to be associated with this Service project | `string` | n/a | yes |
| is\_host\_project | Determines whether this project is set up as a host project | `bool` | `false` | no |
| is\_service\_project | Determines whether this project is set up as a Service project | `bool` | `false` | no |
| labels | Map of labels (i.e. tags) to add to resource | `map(string)` | n/a | yes |
| org\_id | The organization ID this project belongs to.<br>  Only one of org\_id or folder\_id may be specified. <br>  If the org\_id is specified then the project is created at the top level.<br>  If the folder\_id is specified, then the project is created under the specified folder. | `string` | `""` | no |
| project\_name | The project name. The project ID uses this as a base then appends 4 random digits to keep it globally unique | `string` | n/a | yes |
| services | The list of APIs to activate within the project: https://cloud.google.com/service-usage/docs/enabled-service | `list(string)` | <pre>[<br>  "iam.googleapis.com",<br>  "cloudbilling.googleapis.com",<br>  "billingbudgets.googleapis.com",<br>  "cloudresourcemanager.googleapis.com",<br>  "serviceusage.googleapis.com",<br>  "compute.googleapis.com",<br>  "container.googleapis.com",<br>  "storage-api.googleapis.com",<br>  "bigquery.googleapis.com",<br>  "logging.googleapis.com",<br>  "monitoring.googleapis.com"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| project | Project outputs |
| project\_id | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->