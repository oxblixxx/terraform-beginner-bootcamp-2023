#ERROR ENCOUNTERED

Faced a difficulty to upload files to my s3 bucket, I got a fix on [stackoverflo](https://stackoverflow.com/questions/57456167/uploading-multiple-files-in-aws-s3-from-terraform) which worked out. I created a `locals.tf` file. Updated it with this content.

```sh
locals{
  assets_files = flatten([for d in flatten(fileset("${var.portfolio}/assets/*", "*")) : trim( d, "../") ])
}
```

Then updated the `resource_storage_cdn.tf` file to upload files with the below code:

```sh
resource "aws_s3_object" "assets_files" {
  for_each = { for files, file in local.assets_files : files => file }

  bucket       = aws_s3_bucket.bootcamp_bucket.id
  key          = "/assets/${each.value}"
  source       = "${var.portfolio}/assets/${each.value}"
  etag = "${var.portfolio}/assets/${each.value}"
}
```

