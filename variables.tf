variable "project_name" {
  description = "Prefix used for generated local infrastructure files."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,30}$", var.project_name))
    error_message = "project_name must be 2-31 lowercase letters, digits, or hyphens, and start with a letter."
  }
}

variable "environment" {
  description = "Environment label recorded in the infrastructure definitions."
  type        = string
}

variable "region" {
  description = "Informational region label; no cloud region is provisioned by the local provider."
  type        = string
}

variable "artifact_bucket_name" {
  description = "Logical object-storage bucket name represented by a local directory."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.artifact_bucket_name))
    error_message = "artifact_bucket_name must be 3-63 lowercase letters, digits, or hyphens, and start and end with a letter or digit."
  }
}

variable "registry_name" {
  description = "Logical container registry name recorded in a local manifest."
  type        = string
}

variable "compute_resource_name" {
  description = "Logical compute resource name recorded in a local manifest."
  type        = string
}

variable "sample_dataset_csv" {
  description = "Small, synthetic CSV dataset written into the local storage layout."
  type        = string
}

variable "sample_artifact_readme" {
  description = "Description written as a sample ML artifact."
  type        = string
}