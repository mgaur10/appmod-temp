
/*
gcloud beta builds triggers create cloud-source-repositories \
  --name=cloudbuild-launcher-trigger \
  --project=$PROJECT_ID \
  --repo=projects/$PROJECT_ID/repos/hello-world-java \
  --branch-pattern=master \
  --region=us-central1 \
  --service-account=projects/$PROJECT_ID/serviceAccounts/$DEVELOPER_SERVICE_ACCOUNT \
  --build-config=cloudbuild-launcher.yaml \
  --substitutions='_REPO_URL=$(csr.url)'




# To confirm use of   --substitutions='_REPO_URL=$(csr.url)'

resource "google_cloudbuild_trigger" "cloud_source_repositories" {
  name     = "cloud-source-repositories"
  project  = google_project.app_dev_project.project_id
  location = var.network_region

  trigger_template {
    branch_name = "master"
    repo_name   = "projects/${google_project.app_dev_project.project_id}/repos/hello-world-java"
  }

  service_account = google_service_account.developer_service_account.id
  filename        = "$PWD/tmp_files/cloudbuild.yaml"
  # depends_on = [
  #   google_project_iam_member.act_as,
  #   google_project_iam_member.logs_writer
  # ]
}
  */