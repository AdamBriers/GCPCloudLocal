# tf_gcp_gce_instance

Terraform module to build out GCP compute instances. In order to update the OS image or the labels for the instance you will need to force a re-build via the taint command or similar due to the lifecycle rules in this module.                                               |

## Usage

### Minimal Example

```terraform
module "tf_gcp_gce_instance" {
  source                = " modules/gcp_gce_instance"

  gcp_instance_sa_email = "955046673389-compute@developer.gserviceaccount.com"
  instance_name         = "compute-module-test"
  network               = "projects/gc-a-prj-vpchost-0001-3312/global/networks/gc-t-vpc-0001"
  subnetwork            = "projects/gc-a-prj-vpchost-0001-3312/regions/europe-west2/subnetworks/gc-t-snet-0001"
  project               = "gc-t-prj-poc-0001-5473"
  os_image              = "debian-10-buster-v20210122"
}
```

### Extended Example

```terraform
module "tf_gcp_gce_instance" {
  source = "modules/gcp_gce_instance"

  boot_disk_auto_delete   = false
  boot_disk_size          = 200
  boot_disk_type          = "pd-ssd"
  gcp_instance_sa_email   = "955046673389-compute@developer.gserviceaccount.com"
  instance_name           = "compute-module-test"
  instance_tags           = ["firewall-tag"]
  machine_type            = "n1-standard-8"
  metadata_startup_script = "echo hi > /hi.txt"
  network                 = "projects/gc-a-prj-vpchost-0001-3312/global/networks/gc-t-vpc-0001"
  on_host_maintenance     = "TERMINATE"
  os_image                = "debian-10-buster-v20210122"
  project                 = "gc-t-prj-poc-0001-5473"
  subnetwork              = "projects/gc-a-prj-vpchost-0001-3312/regions/europe-west2/subnetworks/gc-t-snet-0001"

  guest_accelerator = {
    type  = "nvidia-tesla-t4"
    count = 1
  }
}
```

### Mandatory Variables

| Name                  | Description                                        | Type   |
| ----------------------| -------------------------------------------------- | ------ |
| gcp_instance_sa_email | The service account used for the instance.         | String |
| instance_name         | Name of the VM instance.                           | String |
| network               | The VPC network the instance will attach to.       | String |
| project               | The project the instance will live in.             | String |

### Optional Variables

| Name                      | Description                                           | Type     | Default                                   |
| ------------------------- | ----------------------------------------------------- | -------- | ----------------------------------------- |
| allow_stopping_for_update | Allow TF to stop the instance to make changes.        | Bool     | false                                     |
| automatic_restart         | Auto restart the instance after Google live migrate.  | Bool     | true                                      |
| boot_disk_auto_delete     | Will the boot disk delete when deleting the instance. | Bool     | true                                      |
| boot_disk_size            | Size of the instance boot disk in GB.                 | Number   | 20                                        |
| boot_disk_type            | What type of disk for the boot disk.                  | String   | pd-standard                               |
| guest_accelerator         | Attaching GPU type and count to the instance.         | Map      | None                                      |
| instance_scope            | Scope permissions for the instance.                   | List     | Empty list                                |
| instance_tags             | What firewall tags to attach to the instance.         | List     | None                                      |
| labels                    | Labels to add.                                        | List     | None                                      |
| machine_type              | Specification of the VM instance.                     | String   | f1-micro                                  |
| metadata_startup_script   | Startup script to pass to the instance                | String   | null                                      |
| on_host_maintenance       | Migrate or terminate on host migration.               | String   | MIGRATE                                   |
| os_image                  | The OS image name the instance will install and use.  | String   | pit-packer-images-prd/pit-centos-7-nvidia |
| preemptible               | Preemptible short lived instance.                     | Bool     | false                                     |
| subnetwork                | The VPC subnetwork the instance will attach to.       | String   | None                                      |
| zone                      | What GCP zone the compute instance will run in.       | String   | europe-west2-a                            |

## Outputs

| Name               | Description               | Type   |
| ------------------ | ------------------------- | ------ |
| instance_name      | The name of the instance. | String |
| instance_self_link | The URI of the instance.  | String |


## References

### Terraform

[Terraform GCP Compute Engine](https://www.terraform.io/docs/providers/google/r/compute_instance.html)

### Google Cloud Platform

[GCP Compute Engine](https://cloud.google.com/compute/docs)
