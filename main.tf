locals {
  dataproc_bucket_write_members  = concat(var.bucket_write_members, var.dataproc_bucket_write_members)
  dataproc_bucket_read_members   = concat(var.bucket_read_members, var.dataproc_bucket_read_members)
  tamr_home_bucket_write_members = concat(var.bucket_write_members, var.tamr_home_bucket_write_members)
  tamr_home_bucket_read_members  = concat(var.bucket_read_members, var.tamr_home_bucket_read_members)
  bucket_prefix                  = var.bucket_name_prefix == "" ? var.project_id : var.bucket_name_prefix
  tamr_bucket_name               = format("%s%s", local.bucket_prefix, var.tamr_bucket_name_suffix)
  dataproc_bucket_name           = format("%s%s", local.bucket_prefix, var.dataproc_bucket_name_suffix)
  delete_enabled                 = var.lifecycle_delete ? [1] : []
  delete_noncurrent_enabled      = var.lifecycle_delete_noncurrent ? [1] : []
  nearline_enabled               = var.lifecycle_nearline ? [1] : []
}
