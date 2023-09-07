# 環境ごとに変わる
variable "env" {
  description = "A name of an environment"
  type        = string
  default     = "prd"
}

variable "app_name" {
  description = "A name of an application"
  type        = string
  default     = "bb1629be"
}

# 環境ごとに変わる
variable "project_id" {
  description = "ID of a GCP project"
  type        = string
}

# 環境ごとに変わる
variable "project_number" {
  description = "Number of a GCP project"
  type        = string
}

variable "region" {
  description = "A region to use the module"
  type        = string
  default     = "asia-northeast1"

  validation {
    condition     = var.region == "asia-northeast1"
    error_message = "The region must be asia-northeast1."
  }
}

variable "zone" {
  description = "A zone to use the module"
  type        = string
  default     = "asia-northeast1-a"

  validation {
    condition     = contains(["asia-northeast1-a", "asia-northeast1-b", "asia-northeast1-c"], var.zone)
    error_message = "The zone must be in asia-northeast1 region."
  }
}

variable "domain" {
  description = "A domain for Cloud Run"
  type        = string
  default     = null
}

variable "domains" {
  description = "A domains for SSL Certification"
  type        = list(string)
  default     = null
}
