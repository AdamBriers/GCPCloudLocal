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

No Modules.

## Resources

| Name |
|------|
| [google_folder](https://registry.terraform.io/providers/hashicorp/google/3.51.0/docs/resources/folder) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| folder\_name | Name of the folder to be created | `string` | n/a | yes |
| org\_id | The organization id for the associated resource/module | `string` | n/a | yes |
| parent\_folder | The ID of the parent folder to apply the resource/module | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| folder\_created | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
