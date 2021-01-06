# Project

- Allows creation and management of a Google Cloud Platform project: https://www.terraform.io/docs/providers/google/r/google_project.html

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| google | >= 3.27 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3.27 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account | The ID of the billing account this project belongs to | `string` | n/a | yes |
| disable\_dependent\_services | Whether services that are enabled and which depend on this service should also be disabled when this service is destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_dependent_services | `bool` | `true` | no |
| disable\_on\_destroy | Whether project services will be disabled when the resources are destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_on_destroy | `bool` | `true` | no |
| folder\_id | The ID of the folder this project should be created under.<br>  Only one of org\_id or folder\_id may be specified. <br>  If the org\_id is specified then the project is created at the top level.<br>  If the folder\_id is specified, then the project is created under the specified folder. | `string` | `""` | no |
| labels | Map of labels (i.e. tags) to add to resource | `map(string)` | n/a | yes |
| org\_id | The organization ID this project belongs to.<br>  Only one of org\_id or folder\_id may be specified. <br>  If the org\_id is specified then the project is created at the top level.<br>  If the folder\_id is specified, then the project is created under the specified folder. | `string` | `""` | no |
| project\_id | The project ID, must be globally unique | `string` | n/a | yes |
| services | The list of APIs to activate within the project: https://cloud.google.com/service-usage/docs/enabled-service | `list(string)` | <pre>[<br>  "iam.googleapis.com",<br>  "cloudbilling.googleapis.com",<br>  "billingbudgets.googleapis.com",<br>  "cloudresourcemanager.googleapis.com",<br>  "serviceusage.googleapis.com",<br>  "compute.googleapis.com",<br>  "container.googleapis.com",<br>  "storage-api.googleapis.com",<br>  "bigquery.googleapis.com",<br>  "cloudbuild.googleapis.com",<br>  "logging.googleapis.com",<br>  "monitoring.googleapis.com"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| project | Project outputs |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->