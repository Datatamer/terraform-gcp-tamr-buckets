variable "project_id" {
  type        = string
  description = "project id for the buckets to be placed into"
}

variable "labels" {
  type        = map(string)
  description = "labels to be attached to the bucket"

  default = {
    product = "external_tamr"
  }
}

variable "bucket_locations" {
  type        = string
  description = "Location for the buckets, default is `US`"
  default     = "US"
}

variable "tamr_home_versioned" {
  type        = bool
  description = "Bool to enable versioning in bucket for tamr"
  default     = true
}
