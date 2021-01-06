locals {
  parent                   = var.parent_folder != "" ? var.parent_folder : "organizations/${var.org_id}"
  parent_resource_type     = "folder"
  organization_id          = var.parent_folder != "" ? null : var.org_id
  activity_logs_bq_uri     = "bigquery.googleapis.com/projects/${var.bigquery_project}/datasets/activity_logs"
  system_event_logs_bq_uri = "bigquery.googleapis.com/projects/${var.bigquery_project}/datasets/system_event_logs"
  data_access_logs_bq_uri  = "bigquery.googleapis.com/projects/${var.bigquery_project}/datasets/data_access_logs"
}

module "log_export_activity_logs" {
  source                 = "./../log-export"
  create_sink            = var.create_sink
  destination_uri        = local.activity_logs_bq_uri
  bigquery_project       = var.bigquery_project
  filter                 = "logName: \"/logs/cloudaudit.googleapis.com%2Factivity\""
  log_sink_name          = "${var.folder_name}_bigquery_activity_logs"
  parent_resource_id     = google_folder.gcpfolder.id
  parent_resource_type   = local.parent_resource_type
  include_children       = true
  unique_writer_identity = true
}

module "log_export_system_event_logs" {
  source                 = "./../log-export"
  create_sink            = var.create_sink
  destination_uri        = local.system_event_logs_bq_uri
  bigquery_project       = var.bigquery_project
  filter                 = "logName: \"/logs/cloudaudit.googleapis.com%2Fsystem_event\""
  log_sink_name          = "${var.folder_name}_bigquery_sysevent_logs"
  parent_resource_id     = google_folder.gcpfolder.id
  parent_resource_type   = local.parent_resource_type
  include_children       = true
  unique_writer_identity = true
}

module "log_export_data_access_logs" {
  source                 = "./../log-export"
  create_sink            = var.create_sink
  destination_uri        = local.data_access_logs_bq_uri
  bigquery_project       = var.bigquery_project
  filter                 = "logName: \"/logs/cloudaudit.googleapis.com%2Fdata_access\""
  log_sink_name          = "${var.folder_name}_bigquery_dataaccess_logs"
  parent_resource_id     = google_folder.gcpfolder.id
  parent_resource_type   = local.parent_resource_type
  include_children       = true
  unique_writer_identity = true
}

module "activity_logs_expiry" {
  source            = "./../table-expiry"
  set_expiry        = var.create_sink
  bigquery_project  = var.bigquery_project
  bigquery_dataset  = element(split("/", local.activity_logs_bq_uri),4)
  expiry_depends_on = [ module.log_export_activity_logs ]
}

module "sysevent_logs_expiry" {
  source           = "./../table-expiry"
  set_expiry       = var.create_sink
  bigquery_project = var.bigquery_project
  bigquery_dataset = element(split("/", local.system_event_logs_bq_uri),4)
  expiry_depends_on = [ module.log_export_system_event_logs ]
}

module "dataaccess_logs_expiry" {
  source           = "./../table-expiry"
  set_expiry       = var.create_sink
  bigquery_project = var.bigquery_project
  bigquery_dataset = element(split("/", local.data_access_logs_bq_uri),4)
  expiry_depends_on = [ module.log_export_data_access_logs ]
}

