project_name          = "mlops-p13"
environment           = "development"
region                = "local"
artifact_bucket_name  = "mlops-p13-artifacts"
registry_name         = "mlops-p13-registry"
compute_resource_name = "mlops-p13-inference"

sample_dataset_csv = <<-CSV
  sample_id,feature_a,feature_b,label
  1,0.12,3.4,0
  2,0.87,1.2,1
  3,0.45,2.1,0
CSV

sample_artifact_readme = <<-TXT
  Sample model artifact placeholder.
  Replace this file with a trained model artifact (for example, model.pkl or model.onnx).
  This local-provider exercise stores only this descriptive text; it does not package model binaries.
TXT
