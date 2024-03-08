locals{
  assets_files = flatten([for d in flatten(fileset("${var.portfolio}/assets/*", "*")) : trim( d, "../") ])
}