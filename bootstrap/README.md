# Bootstrap

## Prerequisites

- Ensure you have the prerequisites covered [here](../CONTRIBUTING.MD) in order to run infra code

## Bootstrap guide

- Get logged in via gcloud:

```bash
gcloud init
gcloud auth application-default login
```

- Create bootstrap resources:
  - Change `terraform.tfvars` file by setting the appropiate org_id, billing_account, log_folder_member, project_id, dev_logs_project_id, prd_logs_project_id, project_labels. The `log_folder_member` is used to specify the Cloud Identity group of the security admins which will have BigQuery view acess to the folder where log sinks are stored
  - Run `terraform init` and then `terraform plan` to see what changes are pending (should be the creation of the bootstrap folder and project, terraform state bucket, terraform service account, IAM permissions for the service account, sink longs folders, sink logs projects, sink logs BigQuery, permissions for security admins)
  - Run `terraform apply` if the above plan looks good and confirm with `yes`
  - Take a note on the output of the apply and save the output somewhere
  - Once the resources have been created, copy `backend.tf-example` file to `backend.tf` and set the bucket to the value of `gcs_bucket_tfstate` from the terraform apply output
  - Run again `terraform init` which will ask if you want to copy the local Terraform state into the remote state bucket - confirm by typing `yes`
  - Remove `terraform.tfstate` and `terraform.tfstate.backup` files. Run another terraform apply which should no longer need to create any new resources
  
- Create bootstrap with CI/CD pipeline
  - In case the customer uses GitHub as a version control system, then copy `cloudbuild.tf` file located in ci-cd folder into the bootstrap folder
  - Ask the customer to create the link between the GCP project created in the initial bootstrap with the GitHub repo he has
  - Change the github references inside the `cloudbuild.tf` file, by setting the appropiate values for `owner` and `name`
  - Run `terraform init` and then `terraform plan` to see what changes are pending (should be changes related only to Cloud Build)
  - Run `terraform apply` if the above plan looks good and confirm with `yes`
  
- Create bootstrap with billing budget and alerts for project creation
  - Copy `provider-impersonate.tf-example` file to `provider.tf` so that it overwrites it
  - Run `gcloud config set auth/impersonate_service_account <account-id>` where the account-id is the terraform service account from the output of the first bootstrap creation run
  - Run `gcloud auth application-default set-quota-project <project-id>` where the project-id is the seed project from the output of the first bootstrap creation run
  - Copy the files located in bootstrap/billing-budget under modules/project folder (with overwrite)
  - Copy `variables-budget.tf-example` file to `variables.tf` so that it overwrites it
  - Copy `main-budget.tf-example` file to `main.tf` so that it overwrites it
  - Copy `terraform-budget.tfvars-example` file to `terraform.tfvars` so that it overwrites it AND adjust the billing budget values accordingly
  - Run `terraform init` and then `terraform plan` to see what changes are pending (should be changes related to setup of billing budget)
  - Run `terraform apply` if the above plan looks good and confirm with `yes`

## Note about "private" key in [terraform.tfstate](terraform.tfstate) in this directory (i.e. `bootstrap`)

Usually terraform state is not to be stored in Git. But given this is a simple resource with no sensitive data, it's better to have the state somewhere.

The "private" property is a place where providers can retain any metadata they need for internal lifecycle tracking, separately from the actual data in "attributes".

"private" in this context means "for use by the provider only", not "secret".

More info: https://serverfault.com/a/981750
