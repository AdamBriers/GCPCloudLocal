# gcs_bucket

Terraform module to manage GCP GCS storage buckets and access to those buckets. Defaults to EU location and MULTI_REGIONAL storage type, versioning enabled, doesn't disable the GCS service on bucket destroy action to avoid conflicts with other buckets created with other calls to this module and doesn't grant any access.

## Usage

### Minimal Example

```terraform
module "tf_gcp_gcs_bucket" {
    source   = "modules/gcs_bucket"

    name       = "gcs_unique_bucket_name"
    project_id = "project_id"
}
```

### Extended Example

```terraform
module "tf_gcp_gcs_bucket" {
    source  = "modules/gcs_bucket"

    name                        = "gcs_unique_bucket_name"
    project_id                  = "project_name"
    bucket_policy_only  = true
    cors = [{
        origin          = ["*"]
        max_age_seconds = "60"
        method          = ["GET"]
        response_header = ["Access-Control-Allow-Credentials: true"]
    }]
    encryption = [{
        default_kms_key_name = "kms_key_name"
    }]
    force_destroy      = true
    lifecycle_rule = [{
        action = [{
            type          = "SetStorageClass"
            storage_class = "MULTI_REGIONAL"
        }]
        condition = [{
            age                   = "1"
            created_before        = "2017-06-13"
            with_state            = "ANY"
            matches_storage_class = ["MULTI_REGIONAL"]
            num_newer_versions    = "1"
        }]
    },
        {
        action = [{
            type          = "SetStorageClass"
            storage_class = "MULTI_REGIONAL"
        }]
        condition = [{
            age            = "1"
            created_before = "2017-06-13"
            with_state     = "ANY"
        }]
    }]
    location           = "EU"
    logging            = [{
        log_bucket        = "gcs_logging_bucket_name"
        log_object_prefix = "some_prefix"
    }]
    requester_pays     = true
    storage_class      = "MULTI_REGIONAL"
    versioning         = false
    website = [{
        main_page_suffix = "index.html"
        not_found_page   = "404.hml"
    }]

    labels = {
        "foo"  = "bar"
        "some" = "label"
    }

    access = {
        "roles/storage.admin"        = ["user:big.ben@placesforpeople.com"],
        "roles/storage.objectAdmin"  = ["serviceAccount:gcs-bucket-service-account@project-id.iam.gserviceaccount.com", "user:london.eye@placesforpeople.com"],
        "roles/storage.objectViewer" = ["group:plaform@placesforpeople.com"]
    }
}
```

## Requirements

The Cloud Storage API needs to be enabled on the project.

## Input Variables

### Mandatory Variables

| Name        | Description                                                                                                                                | Type   |
| :---------- | :----------------------------------------------------------------------------------------------------------------------------------------- | :----- |
| name        | The name of the bucket.                                                                                                                    | String |
| project_id  | The project ID for the project where the bucket will sit.                                                                                  | String |

### Optional Variables

| Name               | Description                                                                                                  | Type   | Defaults       |
| :----------------- | :----------------------------------------------------------------------------------------------------------- | :----- | -------------- |
| access             | Maps of both identities and associated roles to be applied.                                                  | Map    | Empty Map      |
| cors               | The bucket's cross-origin resource sharing (CORS) configuration. Multiple blocks of this type are permitted. | List   | None           |
| encryption         | The bucket's encryption configuration.                                                                       | String | None           |
| force_destroy      | When deleting a bucket, this boolean option will delete all contained objects.                               | Bool   | False          |
| labels             | Map of labels associated with this bucket.                                                                   | Map    | None           |
| lifecycle_rule     | The bucket's lifecycle rules configuration. List of maps of location rules.                                  | List   | None           |
| location           | The geographic location where the bucket should reside.                                                      | String | EU             |
| logging            | The bucket's access & storage Logs configuration.                                                            | List   | None           |
| requester_pays     | Enables 'Requester Pays' on a storage bucket.                                                                | Bool   | False          |
| storage_class      | The storage class of the new bucket. Must match location type.                                               | String | MULTI_REGIONAL |
| uniform_bucket_level_access | Bucket level access policy                                                                          | Bool | True             |
| versioning         | The bucket's versioning configuration.                                                                       | Bool   | True           |
| website            | Configuration if the bucket acts as a website.                                                               | List   | None           |

## Outputs

| Name      | Description                                                     | Type   |
| :-------- | :-------------------------------------------------------------- | :----- |
| name      | The name of the created bucket resource.                        | String |
| self_link | The URI of the created resource.                                | String |
| url       | The base URL of the bucket, in the format `gs://<bucket-name>`. | String |

## References

### Terraform

[Storage Bucket resource](https://www.terraform.io/docs/providers/google/r/storage_bucket.html)

[Storage Bucket IAM resource](https://www.terraform.io/docs/providers/google/r/storage_bucket_iam.html)

### Google Cloud Platform

[GCP Storage](https://cloud.google.com/storage/docs/)

[GCP Storage Bucket Roles](https://cloud.google.com/storage/docs/access-control/iam-roles)
