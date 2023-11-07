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

#Create the service Account primary presentation
resource "google_service_account" "developer_service_account" {
  project      = google_project.app_dev_project.project_id
  account_id   = var.developer_service_account
  display_name = "Assured OSS Account"
}


resource "google_project_iam_member" "developer_service_account" {
  for_each = toset(var.developer_roles)
  project  = google_project.app_dev_project.project_id
  role     = each.value

  member = "serviceAccount:${google_service_account.developer_service_account.email}"

  depends_on = [
    google_service_account.developer_service_account,
  ]
}



resource "google_project_iam_member" "iam_user" {
  for_each = toset(var.end_user_roles)
  project  = google_project.app_dev_project.project_id
  role     = each.value


  member = var.end_user_account
}


resource "google_project_iam_member" "compute_default_account" {
  for_each = toset(var.compute_default_roles)
  project  = google_project.app_dev_project.project_id
  role     = each.value

  member = "serviceAccount:${google_project.app_dev_project.number}-compute@developer.gserviceaccount.com"
  depends_on = [
    time_sleep.wait_enable_service_api,
  ]
}


# Wait delay after privilige propagation
resource "time_sleep" "wait_iam_roles" {
  depends_on = [
    google_project_iam_member.compute_default_account,
    google_project_iam_member.iam_user,
    google_project_iam_member.developer_service_account,
  ]
  create_duration = "55s"
}
