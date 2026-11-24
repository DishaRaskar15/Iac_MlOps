locals {
  generated_root = "${path.module}/generated/${var.project_name}"
  common_tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform-local"
  }
}

resource "local_file" "storage_bucket_configuration" {
  filename = "${local.generated_root}/storage/${var.artifact_bucket_name}/bucket-config.json"
  content = jsonencode({
    name        = var.artifact_bucket_name
    purpose     = "ML datasets and model artifacts"
    environment = var.environment
    region      = var.region
    versioning  = { enabled = true }
    layout      = ["datasets/", "artifacts/"]
    tags        = local.common_tags
  })
}

resource "local_file" "sample_dataset" {
  filename = "${local.generated_root}/storage/${var.artifact_bucket_name}/datasets/sample.csv"
  content  = var.sample_dataset_csv
}

resource "local_file" "sample_model_artifact" {
  filename = "${local.generated_root}/storage/${var.artifact_bucket_name}/artifacts/README.txt"
  content  = var.sample_artifact_readme
}

resource "local_file" "container_registry_definition" {
  filename = "${local.generated_root}/registry/${var.registry_name}.json"
  content = jsonencode({
    name        = var.registry_name
    purpose     = "Container images for ML training and inference"
    image_names = ["training-worker", "inference-api"]
    tags        = local.common_tags
  })
}

resource "local_file" "compute_resource_definition" {
  filename = "${local.generated_root}/compute/${var.compute_resource_name}.json"
  content = jsonencode({
    name        = var.compute_resource_name
    kind        = "container-workload"
    purpose     = "Run ML training and inference workloads"
    image       = "${var.registry_name}/inference-api:latest"
    cpu         = "1"
    memory      = "1Gi"
    environment = var.environment
    tags        = local.common_tags
  })
}

resource "local_file" "iam_role_definition" {
  filename = "${local.generated_root}/iam/ml-platform-role.json"
  content = jsonencode({
    role_name = "${var.project_name}-${var.environment}-ml-platform"
    trust_policy = {
      Version = "2012-10-17"
      Statement = [{
        Effect    = "Allow"
        Principal = { Service = ["training.${var.project_name}.local", "inference.${var.project_name}.local"] }
        Action    = "sts:AssumeRole"
      }]
    }
    tags = local.common_tags
  })
}

resource "local_file" "iam_policy_definition" {
  filename = "${local.generated_root}/iam/ml-platform-policy.json"
  content = jsonencode({
    policy_name = "${var.project_name}-${var.environment}-ml-platform-access"
    policy = {
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = ["s3:ListBucket", "s3:GetObject", "s3:PutObject"]
          Resource = ["arn:local:s3:::${var.artifact_bucket_name}", "arn:local:s3:::${var.artifact_bucket_name}/*"]
        },
        {
          Effect   = "Allow"
          Action   = ["registry:PullImage", "registry:PushImage"]
          Resource = ["registry:local:${var.registry_name}"]
        }
      ]
    }
    note = "Local-provider policy definition only; no IAM principal or permissions are created in a cloud account."
  })
}