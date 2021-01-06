resource "null_resource" "set_table_expiry" {
  count    = var.set_expiry ? 1 : 0
  depends_on = [ var.expiry_depends_on ]
  triggers = {
    run_time = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOT
      gcloud alpha bq tables list --dataset=${var.bigquery_dataset} --project=${var.bigquery_project} --format="value(tableReference.tableId,creationTime)" | while read -r tname tdate
      do
        echo $tdate
        NEW_DATE=$(date +"%s" -d "$tdate + 1 year")
        CURRENT_DATE=$(date '+%s')
        DIFF_SEC=$(expr $NEW_DATE - $CURRENT_DATE)
        echo $DIFF_SEC
        gcloud alpha bq tables update $tname --dataset=${var.bigquery_dataset} --expiration="T$${DIFF_SEC}S" --project=${var.bigquery_project}

      done
  EOT
  }
}
