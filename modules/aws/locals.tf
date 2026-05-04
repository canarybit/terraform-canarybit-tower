locals {
  annotations = merge(var.cvm_annotations, {
    "canarybit.eu:provisioner" = "tower"
  })
}