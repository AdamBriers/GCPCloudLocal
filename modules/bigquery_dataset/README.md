# BigQuery Dataset

Terraform module to manage GCP BigQuery datasets. Defaults EU location, no access permissions and doesn't allow destroying datasets containing tables by default.

## Full TF Example
```
 module "bigquery_dataset" {
      source = "modules/bigquery_dataset"
  
      dataset_id    = "dataset_id"
      description   = "description of the dataset"
      friendly_name = "friendly name of the dataset"
      location      = "EU"
      project       = "1111111111"
  
      default_table_expiration_ms     = 604800000
      default_partition_expiration_ms = 8467892
  
      access = [
          {
              "role"          = "WRITER"
              "special_group" = "projectWriters"
          },
          {
              "role"          = "OWNER"
              "special_group" = "projectOwners"
          },
          {
              "role"          = "READER"
              "special_group" = "projectReaders"
          },
      ]
  
      labels = {
          "foo"  = "bar"
          "some" = "label"
      }
 }
  ```
