# 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| google | ~> 3.51.0 |
| google-beta | ~> 3.51 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.51.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| cloudability_project | ./../project |  |

## Resources

| Name |
|------|
| [google_bigquery_dataset](https://registry.terraform.io/providers/hashicorp/google/3.51.0/docs/resources/bigquery_dataset) |
| [google_project_iam_custom_role](https://registry.terraform.io/providers/hashicorp/google/3.51.0/docs/resources/project_iam_custom_role) |
| [google_project_iam_member](https://registry.terraform.io/providers/hashicorp/google/3.51.0/docs/resources/project_iam_member) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account | The ID of the billing account this project belongs to | `string` | n/a | yes |
| cloudability\_sa | Name of the Cloudability service account to provide access to billing account data | `string` | n/a | yes |
| dataset\_id | ID of the Cloudability Dataset to create | `string` | n/a | yes |
| folder\_id | The ID of the folder this project should be created under.<br>  Only one of org\_id or folder\_id may be specified.<br>  If the org\_id is specified then the project is created at the top level.<br>  If the folder\_id is specified, then the project is created under the specified folder. | `string` | `""` | no |
| labels | Map of labels (i.e. tags) to add to resource | `map(string)` | n/a | yes |
| project\_id | The project ID, must be globally unique | `string` | n/a | yes |
| services | The list of APIs to activate within the project: https://cloud.google.com/service-usage/docs/enabled-service | `list(string)` | <pre>[<br>  "serviceusage.googleapis.com",<br>  "compute.googleapis.com",<br>  "logging.googleapis.com",<br>  "bigquery.googleapis.com",<br>  "cloudresourcemanager.googleapis.com",<br>  "cloudbilling.googleapis.com",<br>  "iam.googleapis.com",<br>  "admin.googleapis.com",<br>  "storage-api.googleapis.com",<br>  "monitoring.googleapis.com",<br>  "compute.googleapis.com"<br>]</pre> | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
