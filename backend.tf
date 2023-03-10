resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name          = "bucket-tfstate-${random_id.instance_id.hex}"
  force_destroy = false
  location      = var.region
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  depends_on = [google_project_service.storage]
}

output "bucket_name" {
  description = "Terraform backend bucket name"
  value       = google_storage_bucket.default.name
}
