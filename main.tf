locals {
  dataproc_bucket_write_members  = concat(var.bucket_write_members, var.dataproc_bucket_write_members)
  dataproc_bucket_read_members   = concat(var.bucket_read_members, var.dataproc_bucket_read_members)
  tamr_home_bucket_write_members = concat(var.bucket_write_members, var.tamr_home_bucket_write_members)
  tamr_home_bucket_read_members  = concat(var.bucket_read_members, var.tamr_home_bucket_read_members)

  bucket_prefix             = var.bucket_name_prefix == "" ? var.project_id : var.bucket_name_prefix
  tamr_bucket_name          = format("%s%s", local.bucket_prefix, var.tamr_bucket_name_suffix)
  dataproc_bucket_name      = format("%s%s", local.bucket_prefix, var.dataproc_bucket_name_suffix)
  delete_enabled            = var.lifecycle_delete ? [1] : []
  delete_noncurrent_enabled = var.lifecycle_delete_noncurrent ? [1] : []
  nearline_enabled          = var.lifecycle_nearline ? [1] : []
}

# bucket meant for tamr home
resource "google_storage_bucket" "tamr_bucket" {
  name     = local.tamr_bucket_name
  location = var.bucket_locations
  project  = var.project_id

  versioning {
    enabled = var.versioning_enabled
  }

  # this rule deletes *all* versions after X days.
  dynamic "lifecycle_rule" {
    for_each = local.delete_enabled
    content {
      condition {
        age = var.lifecycle_delete_days
      }
      action {
        type = "Delete"
      }
    }
  }

  # this rule deletes NONCURRENT versions after X days.
  # this will always keep 2 versions of the file around.
  dynamic "lifecycle_rule" {
    for_each = local.delete_noncurrent_enabled
    content {
      condition {
        num_newer_versions         = 2
        days_since_noncurrent_time = var.lifecycle_delete_days
      }
      action {
        type = "Delete"
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = local.nearline_enabled
    content {
      condition {
        age = var.lifecycle_nearline_days
      }
      action {
        # see https://cloud.google.com/storage/docs/storage-classes
        type          = "SetStorageClass"
        storage_class = "NEARLINE"
      }
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
