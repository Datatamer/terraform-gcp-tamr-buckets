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
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| google | >= 3.18.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 3.18.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | project id for the buckets to be placed into | `string` | n/a | yes |
| bucket\_locations | Location for the buckets, default is `US` | `string` | `"US"` | no |
| labels | labels to be attached to the bucket | `map(string)` | <pre>{<br>  "product": "external_tamr"<br>}</pre> | no |
| tamr\_home\_versioned | Bool to enable versioning in bucket for tamr | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| dataproc\_bucket\_name | n/a |
| tamr\_bucket\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)
