#variable "compartment_ocid" {
   # default = "ocid1.compartment.oc1..aaaaaaaanw2un33l7dsxqgxex7ulxr23xfbu4wwskfjkvwgrjienqarxvxta"
#}
#variable "region" {
   # default = "us-phoenix-1"
#}

#variable "bucket_name" {
 #   default = "resource_manager_demo_bucket"
#}


/*variable "bucket_namespace" {
   default = "axhfmvdnwcm7"
}*/

variable "compartment_ocid" {}
variable "region" {}
variable "bucket_name" {}

provider "oci" {
  region = var.region
}

data "oci_objectstorage_namespace" "namespace" {
    compartment_id = var.compartment_ocid
}

resource "oci_objectstorage_bucket" "create_bucket" {
    # required
    compartment_id = var.compartment_ocid
    name = var.bucket_name
    #namespace = var.bucket_namespace
    namespace = data.oci_objectstorage_namespace.namespace.namespace

    # optional
    access_type = "NoPublicAccess" # <---- updated from "ObjectRead"
}

output "new_bucket" {
    value = oci_objectstorage_bucket.create_bucket
}
