## Deploying resources

Create folders in the env folder, separated in there own folder then add a `terragrunt.hcl` file which will reference the Terraform module and inputs.

## Example
### Folder layout for deploying GCP resources with Terragrunt

```
├ org
|  ├ dev
|  | ├ bigq_dev
|  | |  ├ project
|  | |  | └ terragrunt.hcl
|  | |  └ iam
|  | |    └ terragrunt.hcl
|  | └ bigq_dev2
|  |    ├ project
|  |    | └ terragrunt.hcl
|  |    └ iam
|  |      └ terragrunt.hcl
|  ├ prd
|  | ├ bigq_live
|  | |  ├ project
|  | |  | └ terragrunt.hcl
|  | |  ├ iam
|  | |  | └ terragrunt.hcl
|  | |  └ compute
|  | |    └ terragrunt.hcl
```

