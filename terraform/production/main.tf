provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "random" {
  source = "../modules/random"
}

module "service_account" {
  source = "../modules/service_account"

  app            = var.app_name
  project_id     = var.project_id
  project_number = var.project_number
  random_id      = module.random.util_random_id
}

module "workload_identity_pool" {
  source = "../modules/iam_workload_identity_pool"

  project_id = var.project_id
  random_id  = module.random.util_random_id
}

module "artifact_registry" {
  source = "../modules/artifact_registry"

  project_id = var.project_id
  region     = var.region
}

module "cloud_run" {
  source = "../modules/cloud_run"

  project_id      = var.project_id
  region          = var.region
  service_account = module.service_account.cloud_run_sa_email
  domain          = var.domain
}
