output "tamr_bucket_name" {
  value = google_storage_bucket.tamr_bucket.name
}

output "dataproc_bucket_name" {
  value = google_storage_bucket.tamr_dataproc_bucket.name
}
