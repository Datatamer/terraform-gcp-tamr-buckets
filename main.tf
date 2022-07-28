locals {
  dataproc_bucket_write_members  = concat(var.bucket_write_members, var.dataproc_bucket_write_members)
  dataproc_bucket_read_members   = concat(var.bucket_read_members, var.dataproc_bucket_read_members)
  tamr_home_bucket_write_members = concat(var.bucket_write_members, var.tamr_home_bucket_write_members)
  tamr_home_bucket_read_members  = concat(var.bucket_read_members, var.tamr_home_bucket_read_members)

  bucket_prefix        = var.bucket_name_prefix == "" ? var.project_id : var.bucket_name_prefix
  tamr_bucket_name     = format("%s%s", local.bucket_prefix, var.tamr_bucket_name_suffix)
  dataproc_bucket_name = format("%s%s", local.bucket_prefix, var.dataproc_bucket_name_suffix)
}

# bucket meant for tamr home
resource "google_storage_bucket" "tamr_bucket" {
  name     = local.tamr_bucket_name
  location = var.bucket_locations
  project  = var.project_id

  versioning {
    enabled = var.versioning_enabled
  }

  # see: https://cloud.google.com/storage/docs/lifecycle
  #
  # this deletes GCS objects when these conditions are satisfied
  # - there are current + 5 versions ahead of the object.
  # - the object has been a noncurrent version for at least 32 days (at least one month)
  #
  # These values are not variables on purpose. These shouldn't need to change unless our retention policies change.
  lifecycle_rule {
    condition {
      num_newer_versions         = 6
      days_since_noncurrent_time = 32
    }
    action {
      type = "Delete"
    }
  }
  force_destroy = var.force_destroy

  labels = var.labels
}

resource "google_storage_bucket_iam_member" "bucket_write" {
  count  = length(local.tamr_home_bucket_write_members)
  bucket = google_storage_bucket.tamr_bucket.name
  role   = "roles/storage.legacyBucketWriter"
  member = local.tamr_home_bucket_write_members[count.index]
}

resource "google_storage_bucket_iam_member" "bucket_read_regular" {
  count  = length(local.tamr_home_bucket_read_members)
  bucket = google_storage_bucket.tamr_bucket.name
  role   = "roles/storage.objectViewer"
  member = local.tamr_home_bucket_read_members[count.index]
}

# bucket for dataproc to use
resource "google_storage_bucket" "tamr_dataproc_bucket" {
  name     = local.dataproc_bucket_name
  location = var.bucket_locations
  project  = var.project_id

  versioning {
    enabled = false
  }

  force_destroy = var.force_destroy

  labels = var.labels
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
