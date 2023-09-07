variable "project_id" {
  description = "ID of a GCP project"
  type        = string
  default     = null
}

variable "region" {
  description = "A region to use the module"
  type        = string
  default     = null
}

variable "cloud_run_instance_name" {
  description = "A name of cloud run instance"
  type        = string
  default     = null
}

variable "domains" {
  description = "A domains for SSL Certification"
  type        = list(string)
  default     = null
}
