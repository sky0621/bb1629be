/*
 * GitHub Actions での CI/CD 用
 */
resource "google_service_account" "github_actions_sa" {
  account_id   = "gha-sa"
  display_name = "For GitHub Actions"
  project      = var.project_id
}

resource "google_service_account_iam_binding" "github_actions_sa_iam_binding" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${google_service_account.github_actions_sa.email}"
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/gha-pool-${var.random_id}/attribute.repository/GincoInc/${var.app}",
  ]
}

resource "google_project_iam_member" "github_actions_sa_user_role" {
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
  role    = "roles/iam.serviceAccountUser"
  project = var.project_id
}

resource "google_project_iam_member" "github_actions_sa_artifact_registry_role" {
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
  role    = "roles/artifactregistry.writer"
  project = var.project_id
}

resource "google_project_iam_member" "github_actions_sa_cloud_build_role" {
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
  role    = "roles/cloudbuild.builds.builder"
  project = var.project_id
}

resource "google_project_iam_member" "github_actions_sa_cloud_deploy_role" {
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
  role    = "roles/clouddeploy.operator"
  project = var.project_id
}

resource "google_project_iam_member" "github_actions_sa_storage_role" {
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
  role    = "roles/storage.admin"
  project = var.project_id
}

resource "google_project_iam_member" "github_actions_sa_cloud_run_role" {
  member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
  role    = "roles/run.admin"
  project = var.project_id
}

/*
 * Cloud Run 用
 */
resource "google_service_account" "cloud_run_sa" {
  account_id   = "run-sa"
  display_name = "For Cloud Run"
  project      = var.project_id
}

resource "google_project_iam_member" "cloud_run_sa_user_role" {
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
  role    = "roles/iam.serviceAccountUser"
  project = var.project_id
}
