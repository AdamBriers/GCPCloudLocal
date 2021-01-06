# 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| google | ~> 3.28.0 |
| google-beta | ~> 3.12 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.28.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_domain\_ids | (Only for list constraints) List of cloud identity domain ids allowed access. Default contains client.co.uk | `list(string)` | <pre>[<br>  "C0391mc0z"<br>]</pre> | no |
| bigquery\_location | The location of the BigQuery dataset | `string` | `"EU"` | no |
| bigquery\_project | The target BigQuery project ID for the log sink | `string` | `""` | no |
| billing\_account | The ID of the billing account this project belongs to | `string` | n/a | yes |
| create\_logs\_project | If this is for the root folder, then create a log sink project | `bool` | `false` | no |
| create\_sink | Indicates if should create the log sink or not | `bool` | `false` | no |
| disable\_dependent\_services | Whether services that are enabled and which depend on this service should also be disabled when this service is destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_dependent_services | `bool` | `true` | no |
| disable\_on\_destroy | Whether project services will be disabled when the resources are destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_on_destroy | `bool` | `true` | no |
| folder\_name | Name of the folder to be created | `string` | n/a | yes |
| labels | Map of labels (i.e. tags) to add to resource | `map(string)` | `{}` | no |
| logs\_project\_id | The project ID, must be globally unique | `string` | `""` | no |
| org\_id | The organization id for the associated resource/module | `string` | n/a | yes |
| parent\_folder | The ID of the parent folder to apply the resource/module | `string` | `""` | no |
| require\_oslogin | Sets the enforcement of OSLogin on compute if true | `bool` | `true` | no |
| resource\_locations | (Only for list constraints) List of locations to allow resource creation | `list(string)` | <pre>[<br>  "in:europe-locations"<br>]</pre> | no |
| services | The list of APIs to activate within the project: https://cloud.google.com/service-usage/docs/enabled-service | `list(string)` | <pre>[<br>  "iam.googleapis.com",<br>  "cloudbilling.googleapis.com",<br>  "billingbudgets.googleapis.com",<br>  "cloudresourcemanager.googleapis.com",<br>  "serviceusage.googleapis.com",<br>  "compute.googleapis.com",<br>  "container.googleapis.com",<br>  "storage-api.googleapis.com",<br>  "bigquery.googleapis.com",<br>  "logging.googleapis.com",<br>  "monitoring.googleapis.com"<br>]</pre> | no |
| skip\_default\_network | Sets skip default network policy creation on projects if true | `bool` | `true` | no |
| svc\_acc\_grants | Does not grant project owner rights to default service account if true | `bool` | `true` | no |
| svc\_acc\_key\_creation | Disables the ability to create and download service account keys | `bool` | `true` | no |
| uniform\_bucket | Sets uniform level access to buckets if true | `bool` | `true` | no |
| vm\_external\_ip | Allow or deny for the VMs to have external IP. Default is to deny | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| folder\_created | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
