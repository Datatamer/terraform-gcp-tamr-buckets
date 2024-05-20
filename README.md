<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0, < 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.0, < 6.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.tamr_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.tamr_dataproc_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.bucket_read_regular](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.bucket_write](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.dataproc_bucket_read_regular](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.dataproc_bucket_write](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_locations"></a> [bucket\_locations](#input\_bucket\_locations) | Location for the buckets, default is `US` | `string` | `"US"` | no |
| <a name="input_bucket_name_prefix"></a> [bucket\_name\_prefix](#input\_bucket\_name\_prefix) | prefix to name the buckets | `string` | `""` | no |
| <a name="input_bucket_read_members"></a> [bucket\_read\_members](#input\_bucket\_read\_members) | The list of members to give write access to dataproc and tamr home buckets | `list(string)` | `[]` | no |
| <a name="input_bucket_write_members"></a> [bucket\_write\_members](#input\_bucket\_write\_members) | The list of members to give write access to dataproc and tamr home buckets | `list(string)` | `[]` | no |
| <a name="input_dataproc_bucket_name_suffix"></a> [dataproc\_bucket\_name\_suffix](#input\_dataproc\_bucket\_name\_suffix) | suffix for the name of the dataproc bucket | `string` | `"-dataproc-home"` | no |
| <a name="input_dataproc_bucket_read_members"></a> [dataproc\_bucket\_read\_members](#input\_dataproc\_bucket\_read\_members) | The list of members to give read access to dataproc bucket | `list(string)` | `[]` | no |
| <a name="input_dataproc_bucket_write_members"></a> [dataproc\_bucket\_write\_members](#input\_dataproc\_bucket\_write\_members) | The list of members to give write access to dataproc bucket | `list(string)` | `[]` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | force destroy potentially persistent buckets | `bool` | `false` | no |
| <a name="input_gcs_kms_key_self_link"></a> [gcs\_kms\_key\_self\_link](#input\_gcs\_kms\_key\_self\_link) | The full path to the encryption key used for gcs bucket. | `string` | `""` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | labels to be attached to the bucket | `map(string)` | <pre>{<br>  "product": "external_tamr"<br>}</pre> | no |
| <a name="input_lifecycle_delete"></a> [lifecycle\_delete](#input\_lifecycle\_delete) | Set lifecycle rule to delete all objects after lifecycle\_delete\_days days | `bool` | `false` | no |
| <a name="input_lifecycle_delete_days"></a> [lifecycle\_delete\_days](#input\_lifecycle\_delete\_days) | If lifecycle\_delete is true, delete objects after this many days | `number` | `90` | no |
| <a name="input_lifecycle_delete_noncurrent"></a> [lifecycle\_delete\_noncurrent](#input\_lifecycle\_delete\_noncurrent) | Set lifecycle rule to delete non-current objects after lifecycle\_delete\_days days | `bool` | `false` | no |
| <a name="input_lifecycle_delete_prefix"></a> [lifecycle\_delete\_prefix](#input\_lifecycle\_delete\_prefix) | Object prefixes to apply the lifecycle rule to for delete rule. | `list(string)` | `[]` | no |
| <a name="input_lifecycle_nearline"></a> [lifecycle\_nearline](#input\_lifecycle\_nearline) | Set lifecycle rule to move the objects to nearline storage after lifecycle\_nearline\_days days | `bool` | `false` | no |
| <a name="input_lifecycle_nearline_days"></a> [lifecycle\_nearline\_days](#input\_lifecycle\_nearline\_days) | If lifecycle\_nearline is true, move objects to nearline storage after this many days | `number` | `23` | no |
| <a name="input_lifecycle_nearline_prefix"></a> [lifecycle\_nearline\_prefix](#input\_lifecycle\_nearline\_prefix) | Object prefixes to apply the lifecycle rule to for nearline storage rule. | `list(string)` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | project id for the buckets to be placed into | `string` | n/a | yes |
| <a name="input_tamr_bucket_name_suffix"></a> [tamr\_bucket\_name\_suffix](#input\_tamr\_bucket\_name\_suffix) | suffix for the name of the Tamr bucket | `string` | `"-tamr-home"` | no |
| <a name="input_tamr_home_bucket_read_members"></a> [tamr\_home\_bucket\_read\_members](#input\_tamr\_home\_bucket\_read\_members) | The list of members to give read access to tamr home bucket | `list(string)` | `[]` | no |
| <a name="input_tamr_home_bucket_write_members"></a> [tamr\_home\_bucket\_write\_members](#input\_tamr\_home\_bucket\_write\_members) | The list of members to give write access to tamr home bucket | `list(string)` | `[]` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | whether to enable object versioning on this bucket | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dataproc_bucket_name"></a> [dataproc\_bucket\_name](#output\_dataproc\_bucket\_name) | n/a |
| <a name="output_tamr_bucket_name"></a> [tamr\_bucket\_name](#output\_tamr\_bucket\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
