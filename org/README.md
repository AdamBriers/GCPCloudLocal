# Folder structure and policies

## Prerequisites

- Ensure you have run the bootstrap as covered [here](../bootstrap) in order to run infra code

## Folder guide

- Create folder resources:
  - Inside org folder, edit `org.hcl` file and set the appropiate values for the following: project, bucket, target_service_account, billing_account, org_id, allowed_domain_ids
  - Environment folders are: `dev`, `prd`, `unmanaged`
  - `global` folder is the one created inside prerequisites above setup
  - `org-policies` is a virtual folder, meaning that it's not being created inside the GCP. Its role is to setup Organisation level policies and/or IAM roles
  - In case the customer uses an external tool for billing management like Cloudability, then inside org/global/billing you will find the setup for Cloudability app integration
  - To create the environment GCP folder structure, go into each environment folder of the repo and perform the following commands:
```
find . -not -path '*/.terragrunt-cache/*' -type f -name terragrunt.hcl -printf '%h\n' | sort | xargs -l -i sh -c 'cd {}; terragrunt init --terragrunt-non-interactive -input=false'
terragrunt plan-all
terragrunt apply-all
```  

- Controlling log sinks and organisation policies:
  - Inside each environment folder there is a `terragrunt.hcl` file from where you can control what policies to apply and whether to create log sink or not
  - For org policies, the following values can be set: skip_default_network (true/false), require_oslogin (true/false), svc_acc_key_creation (true/false), uniform_bucket (true/false), svc_acc_grants (true/false), vm_external_ip (true/false), resource_locations (list containining allowed locations)
  - For log sinks, more specifically for Activity logs, System event logs and Data Access logs, you can control it by folder level via create_sink  (true/false), bigquery_project (the Project ID where bigquery has been setup)
  - An example of such config can be [found here](dev/terragrunt.hcl)
  - The `unmanaged` folder is where all the projects in transition state sit or projects that do not require the same level of restriction. An example configuration with less restriction [is here](unmanaged/terragrunt.hcl)
  
