resource "google_iam_workload_identity_pool" "pool" {
  workload_identity_pool_id = "gha-pool-${var.random_id}"
  display_name              = "For GitHub Actions"
  project                   = var.project_id
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "gha-prov-${var.random_id}"
  display_name                       = "For GitHub Actions"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
  project = var.project_id
}
