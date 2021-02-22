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
| [google_organization_iam_member](https://registry.terraform.io/providers/hashicorp/google/3.51.0/docs/resources/organization_iam_member) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| member\_name | Account name or ID to be given permissions to | `string` | n/a | yes |
| member\_type | The type of the account to be granted permissions. Accepted values are user, serviceaccount, group, domain | `string` | n/a | yes |
| org\_iam\_permissions | List of permissions granted to be granted across the GCP organization. | `list(string)` | n/a | yes |
| org\_id | The organization id for the associated resource/module | `string` | n/a | yes |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
