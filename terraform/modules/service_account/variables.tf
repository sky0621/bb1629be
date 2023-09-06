variable "app" {
  description = "A name of a application"
  type        = string
  default     = null
}

variable "project_id" {
  description = "ID of a GCP project"
  type        = string
  default     = null
}

variable "project_number" {
  description = "Number of a GCP project"
  type        = string
  default     = null
}

variable "random_id" {
  description = "random id for pool and provider name"
  type        = string
  default     = null
}
