#############################################
#    Google Artifact Registry Repository    #
#############################################

# Enable Artifact Registry API
resource "google_project_service" "artifactregistry" {
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

# Create Artifact Registry Repository for Docker containers
resource "google_artifact_registry_repository" "my_docker_repo" {
  location      = var.region
  repository_id = var.repository
  description   = "My docker repository"
  format        = "DOCKER"
  depends_on    = [google_project_service.artifactregistry]
}

# Create a service account
resource "google_service_account" "docker_pusher" {
  account_id   = "docker-pusher"
  display_name = "Docker Container Pusher"
  depends_on   = [google_project_service.artifactregistry]
}

# Give service account permission to push to the Artifact Registry Repository
resource "google_artifact_registry_repository_iam_member" "docker_pusher_iam" {
  location   = google_artifact_registry_repository.my_docker_repo.location
  repository = google_artifact_registry_repository.my_docker_repo.repository_id
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.docker_pusher.email}"
  depends_on = [
    google_artifact_registry_repository.my_docker_repo,
    google_service_account.docker_pusher
  ]
}