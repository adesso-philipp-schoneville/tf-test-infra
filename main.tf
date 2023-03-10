#############################################
#               Enable API's                #
#############################################

# Enable IAM API
resource "google_project_service" "iam" {
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

# Enable Cloud Resource Manager API
resource "google_project_service" "resourcemanager" {
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

# Enable Cloud Storage API
resource "google_project_service" "storage" {
  provider           = google
  service            = "storage.googleapis.com"
  disable_on_destroy = false
}
