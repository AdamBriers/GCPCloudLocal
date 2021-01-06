# Log Export: BigQuery destination submodule

This submodule allows you to configure a BigQuery dataset destination that
can be used by the log export created in the root module.

## Usage

The [examples](../../examples) directory contains directories for each destination, and within each destination directory are directories for each parent resource level. Consider the following
example that will configure a BigQuery dataset destination and a log export at the project level:

```hcl
module "log_export" {
  source                 = "terraform-google-modules/log-export/google"
  destination_uri        = "${module.destination.destination_uri}"
  filter                 = "severity >= ERROR"
  log_sink_name          = "bigquery_example_logsink"
  parent_resource_id     = "sample-project"
  parent_resource_type   = "project"
  unique_writer_identity = true
}

module "destination" {
  source                   = "terraform-google-modules/log-export/google//modules/bigquery"
  project_id               = "sample-project"
  dataset_name             = "sample_dataset"
  log_sink_writer_identity = "${module.log_export.writer_identity}"
}
```

At first glance that example seems like a circular dependency as each module declaration is
using an output from the other, however Terraform is able to collect and order all the resources
so that all dependencies are met.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Copyright 2019 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");  
you may not use this file except in compliance with the License.  
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software  
distributed under the License is distributed on an "AS IS" BASIS,  
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
See the License for the specific language governing permissions and  
limitations under the License.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| google | ~> 3.28.0 |
| google-beta | ~> 3.12 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.28.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dataset\_name | The name of the bigquery dataset to be created and used for log entries matching the filter. | `string` | n/a | yes |
| default\_table\_expiration\_ms | Default table expiration time (in ms) | `number` | `3600000` | no |
| delete\_contents\_on\_destroy | (Optional) If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present. | `bool` | `false` | no |
| description | A use-friendly description of the dataset | `string` | `"Log export dataset"` | no |
| labels | Dataset labels | `map(string)` | `{}` | no |
| location | The location of the BigQuery project. | `string` | `"EU"` | no |
| project\_id | The ID of the project in which the bigquery dataset will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| console\_link | The console link to the destination bigquery dataset |
| destination\_uri | The destination URI for the bigquery dataset. |
| project | The project in which the bigquery dataset was created. |
| resource\_id | The resource id for the destination bigquery dataset |
| resource\_name | The resource name for the destination bigquery dataset |
| self\_link | The self\_link URI for the destination bigquery dataset |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
