output "organization_id" {
  description = "GCP Organization ID."
  value       = var.org_id
}

output "billing_account_id" {
  description = "The ID of the billing account to associate projects with."
  value       = var.billing_account
}

output "seed_project_id" {
  description = "Project where service accounts and core APIs will be enabled."
  value       = module.terraform_project.project.project_id
}

output "terraform_sa_email" {
  description = "Email for privileged service account for Terraform."
  value       = google_service_account.org_terraform.email
}

output "rand_sa_email" {
  description = "Email for privileged service account for Terraform."
  value       = google_service_account.rnd_env_terraform.email
}
output "dev_sa_email" {
  description = "Email for privileged service account for Terraform."
  value       = google_service_account.dev_env_terraform.email
}

output "prod_sa_email" {
  description = "Email for privileged service account for Terraform."
  value       = google_service_account.prd_env_terraform.email
}

output "terraform_org_sa_name" {
  description = "Fully qualified name for privileged service account for Terraform."
  value       = google_service_account.org_terraform.name
}

output "terraform_rand_sa_name" {
  description = "Fully qualified name for privileged service account for Terraform."
  value       = google_service_account.rnd_env_terraform.name
}

output "terraform_dev_sa_name" {
  description = "Fully qualified name for privileged service account for Terraform."
  value       = google_service_account.dev_env_terraform.name
}

output "terraform_prod_sa_name" {
  description = "Fully qualified name for privileged service account for Terraform."
  value       = google_service_account.prd_env_terraform.name
}

output "gcs_bucket_tfstate" {
  description = "Bucket used for storing terraform state for foundations pipelines in seed project."
  value       = google_storage_bucket.terraform_bucket.name
}

/* Only for CI/CD with CloudBuild ***
output "gcs_bucket_cloudbuild_artifacts" {
  description = "Bucket used to store Cloud/Build artefacts in CloudBuild project."
  value       = google_storage_bucket.cloudbuild_artifacts.name
}

output "kms_keyring" {
  description = "KMS Keyring created by the module."
  value       = google_kms_key_ring.tf_keyring.name
}

output "kms_crypto_key" {
  description = "KMS key created by the module."
  value       = google_kms_crypto_key.tf_key.name
}
*************************************/
