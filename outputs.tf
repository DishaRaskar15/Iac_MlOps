output "storage_layout_path" {
  description = "Path to the local directory representing the ML object-storage bucket."
  value       = "${local.generated_root}/storage/${var.artifact_bucket_name}"
}

output "sample_dataset_path" {
  description = "Path to the generated sample dataset."
  value       = local_file.sample_dataset.filename
}

output "sample_artifact_path" {
  description = "Path to the generated sample artifact description."
  value       = local_file.sample_model_artifact.filename
}

output "container_registry_definition_path" {
  description = "Path to the local container registry definition."
  value       = local_file.container_registry_definition.filename
}

output "compute_resource_definition_path" {
  description = "Path to the local compute resource definition."
  value       = local_file.compute_resource_definition.filename
}

output "iam_definition_paths" {
  description = "Paths to local role and policy definitions; these are not applied to a cloud IAM system."
  value = [
    local_file.iam_role_definition.filename,
    local_file.iam_policy_definition.filename
  ]
}