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
  value = module.app-dev.developer_service_account
}


output "default_service_account" {
  value = module.app-dev.default_service_account
}

output "ssh_workstation" {
  value = module.app-dev.workstation_ssh_access
}


output "workstation_https_access" {
  value = module.app-dev.workstation_https_access
}


/*
output "workstation_all_attribute" {
  value = module.app-dev.workstation_all_attribute
}
*/

output "gke_cluster" {
  value     = module.app-dev.gke_cluster
  sensitive = true
}