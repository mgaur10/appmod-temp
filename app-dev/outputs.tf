##  Copyright 2023 Google LLC
##  
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##  
##      https://www.apache.org/licenses/LICENSE-2.0
##  
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.


##  This code creates demo environment for CSA - Application Development Architecture Pattern   ##
##  This demo code is not built for production workload ##
/*
output "developer_service_account" {
  value = "${google_service_account.developer_service_account.email}"
}


output "default_service_account" {
  value = "${google_project.app_dev_project.number}-compute@developer.gserviceaccount.com"
}

output "workstation_ssh_access" {
  value = "gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=${google_workstations_workstation_config.workstation_cluster_config_2.workstation_config_id} --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id}"
}


output "workstation_https_access" {
  value = "https://${google_workstations_workstation.hello_world_workstation.host}"
}



output "workstation_all_attribute" {
  value = "gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=${google_workstations_workstation_config.workstation_cluster_config_2.workstation_config_id} --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} -- 'gcloud init && gcloud source repos create hello-world-java && gcloud source repos clone hello-world-java && git config --global user.email 'admin@manishkgaur.altostrat.com' && git config --global user.name 'Manish Gaur' && gcloud source repos clone springboard-java-hello-world --project springboard-dev-env && pushd . && cd springboard-java-hello-world && git checkout main && popd && cp -r springboard-java-hello-world/* springboard-java-hello-world/.mvn springboard-java-hello-world/.gitignore hello-world-java/ && cd hello-world-java && git add . && git commit -m 'first commit' && ./installer.sh && export PROJECT_HOME=/home/user/hello-world-java && export SERVICE_ACCOUNT=${google_service_account.developer_service_account.email} && source ~/.hello-world-dev-config $SERVICE_ACCOUNT $PROJECT_HOME'"
}


*/

output "gke_cluster" {
  value     = google_container_cluster.hello_world_cluster.private_cluster_config[0].peering_name
  sensitive = true
}
