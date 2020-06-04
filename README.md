# Tamr GCS Bucket Module
This module is used to create the recommend gcs bucket setup for a tamr instance deployed into a single tenant gcp project.

This repo follows the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
## Basic
Inline example implementation of the module.  This is the most basic example of what it would look like to use this module.
```
module "minimal" {
  source = "./gcp-tamr-buckets"

  project = "tamr-foo-bar"
}
```

# Resources Created
* two gcs buckets and associated iam policies

# Variables 
## Inputs
Write your Terraform module inputs.
* `project_id` (required): project id for the buckets to be placed into
* `labels` (optional): labels to be attached to the bucket
* `bucket_locations` (optional): Location for the buckets, default is `US`.
* `tamr_home_versioned` (optional): Bool to enable versioning in bucket for tamr

## Outputs
Write your Terraform module outputs.
* `tamr_bucket_name`: name of the bucket created for tamr
* `dataproc_bucket_name`: name of the bucket created for dataproc

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)
