# service_account

Terraform module to manage service accounts and Service Account Key Admin access to those service accounts. By default, no access is granted.

## Usage

### Minimal Example

```terraform
module "service_account" {
  source = "modules/tf_gcp_service_account"

  account_id  = "service-account-id"
  description = "Service Account Description"
  project     = "project-id"
}
```

### Extended Example

```terraform
module "service_account" {
  source = "modules/tf_gcp_service_account"

  account_id  = "service-account-id"
  description = "Service Account Description"
  project     = "project-id"
  members     = [
    "user:john.doe@placesforpeople.co.uk",
    "serviceAccount:gcp-operations@gcp-operations-dev.iam.gserviceaccount.com"
    ]
}
```

## Input Variables

### Mandatory Variables

| Name        | Description                                                                                                        | Type   |
|-------------|--------------------------------------------------------------------------------------------------------------------|--------|
| account_id  | The service account ID. Changing this forces a new service account to be created.                                  | String |
| description | A text description of the service account.                                                                         | String |
| project_id  | The ID of the project that the service account will be created in. Defaults to the provider project configuration. | String |

### Optional Variables

| Name     | Description                                                                              | Type   | Default |
|----------|------------------------------------------------------------------------------------------|--------|---------|
| members  | List of members that require the Service Account Key Admin role on this Service Account. | List   | Empty   |

## Outputs

| Name  | Description                                      | Type   |
|-------|--------------------------------------------------|--------|
| email | The email address of the service account.        | String |
| name  | The fully-qualified name of the service account. | String |

## References

### Terraform

[Service Account Resource](https://www.terraform.io/docs/providers/google/r/google_service_account.html)

### Google Cloud Platform

[Service Accounts](https://cloud.google.com/compute/docs/access/service-accounts)
