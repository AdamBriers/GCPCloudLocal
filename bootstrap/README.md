# Bootstrap
This bootstrap creates the GCP resources in the first instance to get started in GCP.
It creates the following:

- Remote Terraform state and Build container GCS buckets.
- The organisation level Terraform service account that Terraform uses to deploy the resoources.
- The build jobs and triggers for the environments.
- The infrastructure folder and build GCP project.

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
