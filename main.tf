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



module "app-dev" {
  source                     = "./app-dev"
  organization_id            = var.organization_id
  billing_account            = var.billing_account
  project_name               = var.project_name
  vpc_network_name           = var.vpc_network_name
  vpc_subnetwork_name        = var.vpc_subnetwork_name
  network_region             = var.network_region
  network_zone               = var.network_zone
  ip_subnetwork_cidr_primary = var.ip_subnetwork_cidr_primary
  developer_service_account  = var.developer_service_account
  skip_delete                = var.skip_delete

  end_user_account      = var.end_user_account
  end_user_roles        = var.end_user_roles
  developer_roles       = var.developer_roles
  compute_default_roles = var.compute_default_roles


  gke_cluster_name                 = var.gke_cluster_name
  ip_subnetwork_cidr_pod_range     = var.ip_subnetwork_cidr_pod_range
  ip_subnetwork_cidr_service_range = var.ip_subnetwork_cidr_service_range
  gke_subnetwork_master_cidr_range = var.gke_subnetwork_master_cidr_range
  git_user_account                 = var.git_user_account
  git_user_email                   = var.git_user_email
  git_user_name                    = var.git_user_name


  #  iam_secure_tag                    = var.iam_secure_tag
  /* 
  vpc_network_name                  = var.vpc_network_name
  primary_network_region            = var.primary_network_region
  primary_network_zone              = var.primary_network_zone
  primary_presentation_subnetwork   = var.primary_presentation_subnetwork
  primary_middleware_subnetwork     = var.primary_middleware_subnetwork
  primary_database_subnetwork       = var.primary_database_subnetwork
  primary_sub_proxy                 = var.primary_sub_proxy
  primary_ilb_ip                    = var.primary_ilb_ip
  secondary_network_region          = var.secondary_network_region
  secondary_network_zone            = var.secondary_network_zone
  secondary_presentation_subnetwork = var.secondary_presentation_subnetwork
  secondary_middleware_subnetwork   = var.secondary_middleware_subnetwork
  secondary_sub_proxy               = var.secondary_sub_proxy
  secondary_ilb_ip                  = var.secondary_ilb_ip
*/
}

