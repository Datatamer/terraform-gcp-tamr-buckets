# bucket for dataproc to use
resource "google_storage_bucket" "tamr_dataproc_bucket" {
  name     = local.dataproc_bucket_name
  location = var.bucket_locations
  project  = var.project_id

  versioning {
    enabled = false
  }

  encryption {
    default_kms_key_name = var.gcs_kms_key_self_link
  }

  force_destroy = var.force_destroy

  labels = var.labels

  lifecycle {
    ignore_changes = [
      encryption,
    ]
  }
}

resource "google_storage_bucket_iam_member" "dataproc_bucket_write" {
  count  = length(local.dataproc_bucket_write_members)
  bucket = google_storage_bucket.tamr_dataproc_bucket.name
  role   = "roles/storage.legacyBucketWriter"
  member = local.dataproc_bucket_write_members[count.index]
}

resource "google_storage_bucket_iam_member" "dataproc_bucket_read_regular" {
  count  = length(local.dataproc_bucket_read_members)
  bucket = google_storage_bucket.tamr_dataproc_bucket.name
  role   = "roles/storage.objectViewer"
  member = local.dataproc_bucket_read_members[count.index]
}
