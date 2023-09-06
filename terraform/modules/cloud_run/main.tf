resource "google_cloud_run_v2_service" "cloud_run" {
  name     = "app-service"
  ingress  = "INGRESS_TRAFFIC_ALL"
  project  = var.project_id
  location = var.region

  template {
    service_account = var.service_account

    scaling {
      max_instance_count = 3
    }

    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello" # 初期構築時のダミーイメージ
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_v2_service.cloud_run.location
  project  = google_cloud_run_v2_service.cloud_run.project
  service  = google_cloud_run_v2_service.cloud_run.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
