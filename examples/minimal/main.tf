module "minimal" {
  source = "../../"

  project_id         = var.project_id
  bucket_name_prefix = var.bucket_name_prefix
}
