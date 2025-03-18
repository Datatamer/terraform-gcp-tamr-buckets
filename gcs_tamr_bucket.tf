
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
        age            = var.lifecycle_delete_days
        matches_prefix = var.lifecycle_delete_prefix
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
        age            = var.lifecycle_nearline_days
        matches_prefix = var.lifecycle_nearline_prefix
      }
      action {
        # see https://cloud.google.com/storage/docs/storage-classes
        type          = "SetStorageClass"
        storage_class = "NEARLINE"
      }
    }
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
