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


# Create GKE cluster
resource "google_container_cluster" "hello_world_cluster" {
  name     = var.gke_cluster_name
  location = var.network_region
  project  = google_project.app_dev_project.project_id
  # Enabling autopilot for this cluster
  enable_autopilot = true
  #binary_authorization {
  #evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  #}
  network    = google_compute_network.primary_network.self_link
  subnetwork = google_compute_subnetwork.vpc_subnetwork.self_link
  # Setting an empty ip_allocation_policy to allow autopilot cluster to spin up correctly

  /* remove_default_node_pool = false
  initial_node_count       = 2

addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = true
    }
  }

  release_channel {
    channel = "REGULAR"
  }

    node_config {
    preemptible  = false
    machine_type = "e2-medium"
    
    labels = {
      role = "general"
    }
    }
*/
  ip_allocation_policy {
    cluster_secondary_range_name = "pod-range"
    #    cluster_ipv4_cidr_block       = "10.4.0.0/14"
    services_secondary_range_name = "service-range"
    #    services_ipv4_cidr_block      = "10.8.0.0/20"
  }

  /*
 addons_config {
    network_policy_config {
      disabled = false
    }
  }

  network_policy {
    enabled = true
  }
*/
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = var.gke_subnetwork_master_cidr_range
  }

  master_authorized_networks_config {
    #    enabled = true
    cidr_blocks {
      cidr_block   = "${var.private_pool_network}/${var.private_pool_prefix}"
      display_name = "internal"
    }
  }


  depends_on = [
    google_compute_subnetwork.vpc_subnetwork,
    time_sleep.wait_iam_roles,
    time_sleep.wait_for_org_policy
  ]
}
