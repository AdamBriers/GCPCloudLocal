terraform {
  required_version = ">= 0.14.2"

  # Uncomment this after the initial bootstrap to move the terraform state into the GCS Bucket
  backend "gcs" {
    bucket = "gc-a-prj-cloudbld-0001-7087-terraform-state"
    prefix = "terraform/bootstrap/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.51.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2"
    }
  }
}

/*************************************************
  Bootstrap GCP Organization.
*************************************************/

resource "google_folder" "infrastructure" {
  display_name = "infrastructure"
  parent       = "organizations/${var.org_id}"
}

/******************************************
  Create IaC Project
*******************************************/

module "terraform_project" {
  source = "../modules/project"

  project_name    = var.project_name
  billing_account = var.billing_account
  folder_id       = google_folder.infrastructure.id
  host_project_id = "gc-a-prj-vpchost-0001-3312"

  services = var.activate_apis
  labels   = var.project_labels
}

/***********************************************
  GCS Buckets
 ***********************************************/

resource "google_storage_bucket" "terraform_bucket" {
  name                        = "${module.terraform_project.project.project_id}-terraform-state"
  project                     = module.terraform_project.project.project_id
  location                    = var.bucket_location
  uniform_bucket_level_access = true
  force_destroy               = true

  versioning {
    enabled = true
  }

  labels = var.project_labels
}

resource "google_storage_bucket" "cloudbuild_artifacts" {
  name                        = "${module.terraform_project.project.project_id}-cloudbuild"
  project                     = module.terraform_project.project.project_id
  location                    = var.bucket_location
  force_destroy               = true
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  labels = var.project_labels
}

/******************************************
  Service Accounts
*******************************************/

resource "google_service_account" "org_terraform" {
  project      = module.terraform_project.project.project_id
  account_id   = var.terraform_org_sa_name
  display_name = "Organization Terraform Account"
}

resource "google_service_account" "rnd_env_terraform" {
  project      = module.terraform_project.project.project_id
  account_id   = var.terraform_rnd_sa_name
  display_name = "RandD environment Service Account"
}

resource "google_service_account" "dev_env_terraform" {
  project      = module.terraform_project.project.project_id
  account_id   = var.terraform_dev_sa_name
  display_name = "Dev and Test environment Service Account"
}

resource "google_service_account" "prd_env_terraform" {
  project      = module.terraform_project.project.project_id
  account_id   = var.terraform_prd_sa_name
  display_name = "Prod environment Service Account"
}

/***********************************************
  Service Account access to GCS Buckets
 ***********************************************/

resource "google_storage_bucket_iam_member" "org_terraform_state_iam" {
  bucket = google_storage_bucket.terraform_bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.org_terraform.email}"
}

resource "google_storage_bucket_iam_member" "org_cloud_build_iam" {
  bucket = google_storage_bucket.cloudbuild_artifacts.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.org_terraform.email}"
}

# resource "google_storage_bucket_iam_member" "rnd_terraform_state_iam" {
#   bucket = google_storage_bucket.terraform_bucket.name
#   role   = "roles/storage.admin"
#   member = "serviceAccount:${google_service_account.rnd_env_terraform.email}"
# }

# resource "google_storage_bucket_iam_member" "rnd_cloud_build_iam" {
#   bucket = google_storage_bucket.cloudbuild_artifacts.name
#   role   = "roles/storage.admin"
#   member = "serviceAccount:${google_service_account.rnd_env_terraform.email}"
# }

# resource "google_storage_bucket_iam_member" "dev_terraform_state_iam" {
#   bucket = google_storage_bucket.terraform_bucket.name
#   role   = "roles/storage.admin"
#   member = "serviceAccount:${google_service_account.dev_env_terraform.email}"
# }

# resource "google_storage_bucket_iam_member" "dev_cloud_build_iam" {
#   bucket = google_storage_bucket.cloudbuild_artifacts.name
#   role   = "roles/storage.admin"
#   member = "serviceAccount:${google_service_account.rnd_dev_terraform.email}"
# }

# resource "google_storage_bucket_iam_member" "prd_terraform_state_iam" {
#   bucket = google_storage_bucket.terraform_bucket.name
#   role   = "roles/storage.admin"
#   member = "serviceAccount:${google_service_account.prd_env_terraform.email}"
# }

# resource "google_storage_bucket_iam_member" "prd_cloud_build_iam" {
#   bucket = google_storage_bucket.cloudbuild_artifacts.name
#   role   = "roles/storage.admin"
#   member = "serviceAccount:${google_service_account.prd_dev_terraform.email}"
# }

/********************************************************
  Organization permissions for Terraform service account.
 ********************************************************/

resource "google_organization_iam_member" "tf_sa_org_perms" {
  for_each = toset(var.sa_org_iam_permissions)

  org_id = var.org_id
  role   = each.value
  member = "serviceAccount:${google_service_account.org_terraform.email}"
}

/***********************************************
  Cloud Build - IAM
 ***********************************************/

resource "google_storage_bucket_iam_member" "cloudbuild_artifacts_iam" {
  bucket     = google_storage_bucket.cloudbuild_artifacts.name
  role       = "roles/storage.admin"
  member     = "serviceAccount:${module.terraform_project.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [module.terraform_project]
}

resource "google_service_account_iam_member" "cloudbuild_terraform_sa_impersonate_permissions" {
  service_account_id = google_service_account.org_terraform.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${module.terraform_project.project.number}@cloudbuild.gserviceaccount.com"
  depends_on         = [module.terraform_project]
}

resource "google_project_iam_member" "cloudbuild_serviceusage_consumer" {
  project    = module.terraform_project.project.project_id
  role       = "roles/serviceusage.serviceUsageConsumer"
  member     = "serviceAccount:${module.terraform_project.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [module.terraform_project]
}

# Required to allow cloud build to access state with impersonation.
resource "google_storage_bucket_iam_member" "cloudbuild_state_iam" {
  bucket     = google_storage_bucket.terraform_bucket.name
  role       = "roles/storage.admin"
  member     = "serviceAccount:${module.terraform_project.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [module.terraform_project]
}

/***********************************************
 Source Reposirtory - Create Cloud Source Repo
 ***********************************************/

resource "google_sourcerepo_repository" "this" {
  name    = "placesforpeople"
  project = module.terraform_project.project.project_id
}


/***********************************************
 Cloud Build - Terraform builder
 ***********************************************/

resource "null_resource" "cloudbuild_terraform_builder" {
  triggers = {
    project_id_cloudbuild_project = module.terraform_project.project.project_id
    terraform_docs_version        = var.terraform_docs_version
  }

  provisioner "local-exec" {
    command = <<EOT
      gcloud builds submit ${path.module}/cloudbuild_builder/ \
      --project ${module.terraform_project.project.project_id} \
      --gcs-source-staging-dir="gs://${google_storage_bucket.cloudbuild_artifacts.name}/staging" \
      --config=${path.module}/cloudbuild_builder/cloudbuild.yaml \
      --substitutions=_TERRAFORM_DOCS_VERSION=${var.terraform_docs_version}
  EOT
  }
  depends_on = [
    module.terraform_project,
  ]
}

/***********************************************
 Cloud Build RnD - Branch trigger for master
 ***********************************************/

resource "google_cloudbuild_trigger" "rnd_master_push_trigger" {
  project        = module.terraform_project.project.project_id
  name           = "rnd-master-branch-build-apply"
  description    = "RandD terragrunt apply on push to master"
  filename       = "cloudbuild-tg-plan-apply.yaml"
  included_files = ["org/rnd/*"]
  #ignored_files  = ["org/prd/*", "org/dev/*", "org/infrastructure/*", "org/secops/*", "modules/*"]
  depends_on     = [null_resource.cloudbuild_terraform_builder]

  trigger_template {
    project_id  = module.terraform_project.project.project_id
    repo_name   = google_sourcerepo_repository.this.name
    branch_name = "^master$"
  }

  substitutions = {
    _ENVIRONMENT          = "rnd"
    _TF_SA_EMAIL          = google_service_account.org_terraform.email
    _ARTIFACT_BUCKET_NAME = google_storage_bucket.cloudbuild_artifacts.name
  }
}

/*****************************************************
 Cloud Build RnD - Branch trigger for non-master branches
 ****************************************************/

resource "google_cloudbuild_trigger" "rnd_non_master_push_trigger" {
  project        = module.terraform_project.project.project_id
  name           = "rnd-non-master-branch-plan"
  description    = "RandD terragrunt on push request to non master branches."
  filename       = "cloudbuild-tg-plan.yaml"
  included_files = ["org/rnd/*"]
  #ignored_files  = ["org/prd/*", "org/dev/*", "org/infrastructure/*", "org/secops/*", "modules/*"]
  depends_on     = [null_resource.cloudbuild_terraform_builder]

  trigger_template {
    project_id   = module.terraform_project.project.project_id
    repo_name    = google_sourcerepo_repository.this.name
    branch_name  = "^master$"
    invert_regex = true
  }

  substitutions = {
    _ENVIRONMENT          = "rnd"
    _TF_SA_EMAIL          = google_service_account.org_terraform.email
    _ARTIFACT_BUCKET_NAME = google_storage_bucket.cloudbuild_artifacts.name
  }
}

/***********************************************
 Cloud Build Dev - Branch trigger for master
 ***********************************************/

resource "google_cloudbuild_trigger" "dev_master_push_trigger" {
  project        = module.terraform_project.project.project_id
  name           = "dev-master-branch-build-apply"
  description    = "Dev terragrunt apply on push to master"
  filename       = "cloudbuild-tg-plan-apply.yaml"
  included_files = ["org/dev/*"]
  #ignored_files  = ["org/prd/*", "org/rnd/*", "org/infrastructure/*", "org/secops/*", "modules/*"]
  depends_on     = [null_resource.cloudbuild_terraform_builder]

  trigger_template {
    project_id  = module.terraform_project.project.project_id
    repo_name   = google_sourcerepo_repository.this.name
    branch_name = "^master$"
  }

  substitutions = {
    _ENVIRONMENT          = "dev"
    _TF_SA_EMAIL          = google_service_account.org_terraform.email
    _ARTIFACT_BUCKET_NAME = google_storage_bucket.cloudbuild_artifacts.name
  }
}

/*****************************************************
 Cloud Build Dev - Branch trigger for non-master branches
 ****************************************************/

resource "google_cloudbuild_trigger" "dev_non_master_push_trigger" {
  project        = module.terraform_project.project.project_id
  name           = "dev-non-master-branch-plan"
  description    = "Dev terragrunt on push request to non master branches."
  filename       = "cloudbuild-tg-plan.yaml"
  included_files = ["org/dev/*"]
  #ignored_files  = ["org/prd/*", "org/rnd/*", "org/infrastructure/*", "org/secops/*", "modules/*"]
  depends_on     = [null_resource.cloudbuild_terraform_builder]

  trigger_template {
    project_id   = module.terraform_project.project.project_id
    repo_name    = google_sourcerepo_repository.this.name
    branch_name  = "^master$"
    invert_regex = true
  }

  substitutions = {
    _ENVIRONMENT          = "dev"
    _TF_SA_EMAIL          = google_service_account.org_terraform.email
    _ARTIFACT_BUCKET_NAME = google_storage_bucket.cloudbuild_artifacts.name
  }
}

/***********************************************
 Cloud Build Prod - Branch trigger for master
 ***********************************************/

resource "google_cloudbuild_trigger" "prd-master_push_trigger" {
  project        = module.terraform_project.project.project_id
  name           = "prod-master-branch-build-apply"
  description    = "Prod terragrunt apply on push to master"
  filename       = "cloudbuild-tg-plan-apply.yaml"
  included_files = ["org/prd/*"]
  #ignored_files  = ["org/dev/*", "org/rnd/*", "org/infrastructure/*", "org/secops/*", "modules/*"]
  depends_on     = [null_resource.cloudbuild_terraform_builder]

  trigger_template {
    project_id  = module.terraform_project.project.project_id
    repo_name   = google_sourcerepo_repository.this.name
    branch_name = "^master$"
  }

  substitutions = {
    _ENVIRONMENT          = "prd"
    _TF_SA_EMAIL          = google_service_account.org_terraform.email
    _ARTIFACT_BUCKET_NAME = google_storage_bucket.cloudbuild_artifacts.name
  }
}

/*****************************************************
 Cloud Build Prod - Branch trigger for non-master branches
 ****************************************************/

resource "google_cloudbuild_trigger" "prd-non_master_push_trigger" {
  project        = module.terraform_project.project.project_id
  name           = "prod-non-master-branch-plan"
  description    = "Prod terragrunt on push request to non master branches."
  filename       = "cloudbuild-tg-plan.yaml"
  included_files = ["org/prd/*"]
  #ignored_files  = ["org/dev/*", "org/rnd/*", "org/infrastructure/*", "org/secops/*", "modules/*"]
  depends_on     = [null_resource.cloudbuild_terraform_builder]

  trigger_template {
    project_id   = module.terraform_project.project.project_id
    repo_name    = google_sourcerepo_repository.this.name
    branch_name  = "^master$"
    invert_regex = true
  }

  substitutions = {
    _ENVIRONMENT          = "prd"
    _TF_SA_EMAIL          = google_service_account.org_terraform.email
    _ARTIFACT_BUCKET_NAME = google_storage_bucket.cloudbuild_artifacts.name
  }
}

/***********************************************
 Cloud Build Infratructure - Branch trigger for master
 ***********************************************/

resource "google_cloudbuild_trigger" "infra-master_push_trigger" {
  project        = module.terraform_project.project.project_id
  name           = "infrastructure-master-branch-build-apply"
  description    = "Infrastructure terragrunt apply on push to master"
  filename       = "cloudbuild-tg-plan-apply.yaml"
  included_files = ["org/infrastructure/*"]
  #ignored_files  = ["org/dev/*", "org/rnd/*", "org/prd/*", "org/secops/*", "modules/*"]
  depends_on     = [null_resource.cloudbuild_terraform_builder]

  trigger_template {
    project_id  = module.terraform_project.project.project_id
    repo_name   = google_sourcerepo_repository.this.name
    branch_name = "^master$"
  }

  substitutions = {
    _ENVIRONMENT          = "infrastructure"
    _TF_SA_EMAIL          = google_service_account.org_terraform.email
    _ARTIFACT_BUCKET_NAME = google_storage_bucket.cloudbuild_artifacts.name
  }
}

/*****************************************************
 Cloud Build Infrastructure - Branch trigger for non-master branches
 ****************************************************/

resource "google_cloudbuild_trigger" "infra-non_master_push_trigger" {
  project        = module.terraform_project.project.project_id
  name           = "infrastructure-non-master-branch-plan"
  description    = "Infratructure terragrunt on push request to non master branches."
  filename       = "cloudbuild-tg-plan.yaml"
  included_files = ["org/infrastructure/*"]
  #ignored_files  = ["org/dev/*", "org/rnd/*", "org/prd/*", "org/secops/*", "modules/*"]
  depends_on     = [null_resource.cloudbuild_terraform_builder]

  trigger_template {
    project_id   = module.terraform_project.project.project_id
    repo_name    = google_sourcerepo_repository.this.name
    branch_name  = "^master$"
    invert_regex = true
  }

  substitutions = {
    _ENVIRONMENT          = "infrastructure"
    _TF_SA_EMAIL          = google_service_account.org_terraform.email
    _ARTIFACT_BUCKET_NAME = google_storage_bucket.cloudbuild_artifacts.name
  }
}

/***********************************************
 Cloud Build SecOps - Branch trigger for master
 ***********************************************/

resource "google_cloudbuild_trigger" "secops-master_push_trigger" {
  project        = module.terraform_project.project.project_id
  name           = "secops-master-branch-build-apply"
  description    = "SecOps terragrunt apply on push to master"
  filename       = "cloudbuild-tg-plan-apply.yaml"
  included_files = ["org/secops/*"]
  #ignored_files  = ["org/dev/*", "org/rnd/*", "org/prd/*", "org/infrastructure/*", "modules/*"]
  depends_on     = [null_resource.cloudbuild_terraform_builder]

  trigger_template {
    project_id  = module.terraform_project.project.project_id
    repo_name   = google_sourcerepo_repository.this.name
    branch_name = "^master$"
  }

  substitutions = {
    _ENVIRONMENT          = "secops"
    _TF_SA_EMAIL          = google_service_account.org_terraform.email
    _ARTIFACT_BUCKET_NAME = google_storage_bucket.cloudbuild_artifacts.name
  }
}

/*****************************************************
 Cloud Build SecOps - Branch trigger for non-master branches
 ****************************************************/

resource "google_cloudbuild_trigger" "secops-non_master_push_trigger" {
  project        = module.terraform_project.project.project_id
  name           = "secops-non-master-branch-plan"
  description    = "SecOps terragrunt on push request to non master branches."
  filename       = "cloudbuild-tg-plan.yaml"
  included_files = ["org/secops/*"]
  #ignored_files  = ["org/dev/*", "org/rnd/*", "org/prd/*", "org/infrastructure/*", "modules/*"]
  depends_on     = [null_resource.cloudbuild_terraform_builder]

  trigger_template {
    project_id   = module.terraform_project.project.project_id
    repo_name    = google_sourcerepo_repository.this.name
    branch_name  = "^master$"
    invert_regex = true
  }

  substitutions = {
    _ENVIRONMENT          = "secops"
    _TF_SA_EMAIL          = google_service_account.org_terraform.email
    _ARTIFACT_BUCKET_NAME = google_storage_bucket.cloudbuild_artifacts.name
  }
}