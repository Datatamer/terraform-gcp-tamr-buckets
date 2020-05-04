# bucket meant for tamr home
resource "google_storage_bucket" "tamr_bucket" {
  name     = "${var.project_id}-tamr-home"
  location = var.bucket_locations
  project  = var.project_id

  versioning {
    enabled = var.tamr_home_versioned
  }

  labels = var.labels
}

resource "google_storage_bucket_iam_binding" "bucket_write" {
  bucket = google_storage_bucket.tamr_bucket.name
  role   = "roles/storage.legacyBucketWriter"

  members = [
    "group:gce-admin@tamr.com",
    "group:${var.project_id}-user@tamr.com",
    "serviceAccount:tsc-instance@${var.project_id}.iam.gserviceaccount.com",
  ]
}

resource "google_storage_bucket_iam_binding" "bucket_read_regular" {
  bucket = google_storage_bucket.tamr_bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "group:gce-admin@tamr.com",
    "group:${var.project_id}-user@tamr.com",
    "group:${var.project_id}-readonly@tamr.com",
    "serviceAccount:tsc-instance@${var.project_id}.iam.gserviceaccount.com",
    "serviceAccount:k8s-workers@${var.project_id}.iam.gserviceaccount.com",
  ]
}

# bucket for dataproc to use, note the no versioning
resource "google_storage_bucket" "tamr_dataproc_bucket" {
  name     = "${var.project_id}-dataproc-home"
  location = var.bucket_locations
  project  = var.project_id

  versioning {
    enabled = false
  }

  labels = var.labels
}

resource "google_storage_bucket_iam_binding" "dataproc_bucket_write" {
  bucket = google_storage_bucket.tamr_dataproc_bucket.name
  role   = "roles/storage.legacyBucketWriter"

  members = [
    "group:gce-admin@tamr.com",
    "group:${var.project_id}-user@tamr.com",
    "serviceAccount:tsc-instance@${var.project_id}.iam.gserviceaccount.com",
  ]
}

resource "google_storage_bucket_iam_binding" "dataproc_bucket_read_regular" {
  bucket = google_storage_bucket.tamr_dataproc_bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "group:gce-admin@tamr.com",
    "group:${var.project_id}-user@tamr.com",
    "group:${var.project_id}-readonly@tamr.com",
    "serviceAccount:tsc-instance@${var.project_id}.iam.gserviceaccount.com",
    "serviceAccount:k8s-workers@${var.project_id}.iam.gserviceaccount.com",
  ]
}
