# 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| google | ~> 3.28.0 |
| google-beta | ~> 3.12 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_domain\_ids | (Only for list constraints) List of cloud identity domain ids allowed access. Default contains client.co.uk | `list(string)` | <pre>[<br>  "C0391mc0z"<br>]</pre> | no |
| billing\_admin\_group | Organisational GCP Billing Admin group | `string` | n/a | yes |
| billing\_users\_group | Organisational GCP Billing User group | `string` | n/a | yes |
| billingadmin\_org\_iam\_permissions | List of permissions granted to Billing Admin group across the GCP organization. | `list(string)` | n/a | yes |
| billingusers\_org\_iam\_permissions | List of permissions granted to Billing User Group across the GCP organization. | `list(string)` | n/a | yes |
| member\_type | The type of the account to be granted permissions. Accepted values are user, serviceaccount, group, domain | `string` | `"group"` | no |
| org\_admin\_group | Organisational GCP Admin group | `string` | n/a | yes |
| org\_id | The organization id for the associated resource/module | `string` | `""` | no |
| orgadmin\_org\_iam\_permissions | List of permissions granted to Organisational Admin group across the GCP organization. | `list(string)` | n/a | yes |
| sec\_admin\_group | Organisational GCP Security Admin group | `string` | n/a | yes |
| secadmin\_org\_iam\_permissions | List of permissions granted to Security Admin group across the GCP organization. | `list(string)` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
