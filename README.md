# Tamr GCS Bucket Module
This module is used to create the recommend gcs bucket setup for a tamr instance deployed into a single tenant gcp project.

This repo follows the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Examples
## Minimal
This is the most basic example of what it would look like to use this module
- [Minimal](https://github.com/Datatamer/terraform-gcp-tamr-buckets/tree/master/examples/minimal)

# Resources Created
* two gcs buckets and associated iam policies

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| google | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | project id for the buckets to be placed into | `string` | n/a | yes |
| bucket\_locations | Location for the buckets, default is `US` | `string` | `"US"` | no |
| bucket\_name\_prefix | prefix to name the buckets | `string` | `""` | no |
| bucket\_read\_members | The list of members to give write access to dataproc and tamr home buckets | `list(string)` | `[]` | no |
| bucket\_write\_members | The list of members to give write access to dataproc and tamr home buckets | `list(string)` | `[]` | no |
| dataproc\_bucket\_name\_suffix | suffix for the name of the dataproc bucket | `string` | `"-dataproc-home"` | no |
| dataproc\_bucket\_read\_members | The list of members to give read access to dataproc bucket | `list(string)` | `[]` | no |
| dataproc\_bucket\_write\_members | The list of members to give write access to dataproc bucket | `list(string)` | `[]` | no |
| force\_destroy | force destroy potentially persistent buckets | `bool` | `false` | no |
| labels | labels to be attached to the bucket | `map(string)` | <pre>{<br>  "product": "external_tamr"<br>}</pre> | no |
| tamr\_bucket\_name\_suffix | suffix for the name of the Tamr bucket | `string` | `"-tamr-home"` | no |
| tamr\_home\_bucket\_read\_members | The list of members to give read access to tamr home bucket | `list(string)` | `[]` | no |
| tamr\_home\_bucket\_write\_members | The list of members to give write access to tamr home bucket | `list(string)` | `[]` | no |
| versioning\_enabled | whether to enable object versioning on this bucket | `bool` | `true` | no |

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

# Development
## Generating Docs
Run `make terraform/docs` to generate the section of docs around terraform inputs, outputs and requirements.

## Checkstyles
Run `make lint`, this will run terraform fmt, in addition to a few other checks to detect whitespace issues.
NOTE: this requires having docker working on the machine running the test

## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
