# Folder structure and policies

## Prerequisites

- Ensure you have run the bootstrap as covered [here](../bootstrap) in order to run infra code

## Folder guide

- Create folder resources:
  - Inside the org folder, create the env folder and then add a `terragrunt.hcl` with the `folder_name` input. The `org_id` should be already in the root `org.hcl`.
  - Environment folders are: `dev`, `prd`, `rnd` and `secops` which is the central logging project.
  - `infrastructure` folder is the one created inside prerequisites above setup
  - To create the environment GCP folder structure, go into each environment folder of the repo and perform the following commands:
```
find . -not -path '*/.terragrunt-cache/*' -type f -name terragrunt.hcl -printf '%h\n' | sort | xargs -l -i sh -c 'cd {}; terragrunt init --terragrunt-non-interactive -input=false'
terragrunt plan-all
terragrunt apply-all
```  

- Controlling log sinks and organisation policies:
  - Inside each environment folder there is a `terragrunt.hcl` this creates the folder in GCP. 
  - For org policies, the following values can be set: skip_default_network (true/false), require_oslogin (true/false), uniform_bucket (true/false), vm_external_ip (true/false), resource_locations (list containing allowed locations) via `infrastructure/org_policies/terragrunt.hcl` variables can be found in `modules/org_policies`.
  - For log sinks, more specifically for Activity logs, System event logs and Data Access logs, you can control it at the org level by enabling or disabling it and also changing the filter via `secops/log_sink/terragrunt.hcl`
  
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

