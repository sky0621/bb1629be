resource "google_artifact_registry_repository" "registry-repo" {
  location      = var.region
  repository_id = "app-repo"
  format        = "DOCKER"
  project       = var.project_id
}
