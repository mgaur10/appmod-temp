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


variable "organization_id" {
  type        = string
  description = "organization id required"
  default     = "873180247571"
}

variable "billing_account" {
  type        = string
  description = "billing account required"
  default     = "01660F-E4C304-5C8D2B"
}

variable "project_name" {
  type        = string
  description = "Project ID to deploy resources"
  default     = "csa-app-dev-3"
}

variable "developer_service_account" {
  type        = string
  description = "inner/outer dev loop service agent"
  default     = "developer-service-account"

}


variable "skip_delete" {
  description = " If true, the Terraform resource can be deleted without deleting the Project via the Google API."
  default     = "false"
}



variable "end_user_account" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = string
  default     = "user:admin@manishkgaur.altostrat.com"
}






variable "developer_roles" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = list(string)
  default = [
    "roles/artifactregistry.writer",
    "roles/binaryauthorization.attestorsViewer",
    "roles/cloudbuild.builds.builder",
    "roles/clouddeploy.releaser",
    "roles/clouddeploy.serviceAgent",
    "roles/cloudkms.signerVerifier",
    "roles/containeranalysis.notes.attacher",
    "roles/containeranalysis.occurrences.editor",
    "roles/containeranalysis.notes.occurrences.viewer",
    "roles/logging.logWriter",
    "roles/ondemandscanning.admin",
    "roles/storage.objectCreator",
    "roles/storage.objectViewer",
    "roles/containeranalysis.notes.occurrences.viewer", # For Biauth attestation
    "roles/binaryauthorization.attestorsVerifier",      # For Biauth attestation
    "roles/source.reader",
  ]
}



variable "end_user_roles" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = list(string)
  default = [
    "roles/iam.serviceAccountUser",
    "roles/iam.serviceAccountTokenCreator",
    "roles/iam.serviceAccountAdmin",
  ]
}



variable "compute_default_roles" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = list(string)
  default = [
    "roles/clouddeploy.serviceAgent",
    "roles/cloudbuild.serviceAgent",
    "roles/container.serviceAgent",
    #   "roles/compute.serviceAgent",  # This role was added during troubleshoot
    #   "roles/editor",                # This role was added during troubleshoot
    "roles/logging.logWriter",
    "roles/storage.objectCreator",
    "roles/storage.objectViewer",
  ]
}




variable "vpc_network_name" {
  type        = string
  description = "VPC network name"
  default     = "hello-world-network"
}

variable "vpc_subnetwork_name" {
  type        = string
  description = "VPC subnetwork name"
  default     = "hello-world-cluster-subnet"
}

variable "network_region" {
  type        = string
  description = "Primary network region for micro segmentation architecture"
  default     = "us-central1"
}

variable "network_zone" {
  type        = string
  description = "Primary network zone"
  default     = "us-central1-a"
}


variable "ip_subnetwork_cidr_primary" {
  type        = string
  description = "Subnet range for primary presentation layer"
  default     = "192.168.0.0/20"
}


variable "ip_subnetwork_cidr_pod_range" {
  type        = string
  description = "Subnet range for primary presentation layer"
  default     = "10.4.0.0/14"
}

variable "ip_subnetwork_cidr_service_range" {
  type        = string
  description = "Subnet range for primary presentation layer"
  default     = "10.0.32.0/20"
}


variable "gke_subnetwork_master_cidr_range" {
  type        = string
  description = "Subnet range for primary presentation layer"
  default     = "172.16.0.0/28"
}



variable "gke_cluster_name" {
  type        = string
  description = "GKE cluster name"
  default     = "hello-world-cluster"
}


variable "git_user_account" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = string
  default     = "admin@manishkgaur.altostrat.com"
}

variable "git_user_email" {
  type        = string
  description = "User email for Git"
  default     = "test_user@example.com"
}

variable "git_user_name" {
  type        = string
  description = "User name for Git"
  default     = "Test User"
}





/*
# Project ID of the project containing the Private GKE Cluster
GKE_CLUSTER_PROJECT=$PROJECT_ID
# Private GKE Cluster for deployment
GKE_CLUSTER_NAME=hello-world-cluster
# VPC used for the Private GKE cluster
VPC_NAME=hello-world-network

VPC_HOST_PROJECT="$GKE_CLUSTER_PROJECT"
VPC_HOST_PROJECT_NUMBER="$(gcloud projects describe $VPC_HOST_PROJECT --format 'value(projectNumber)')" 
# --- End Vars for local script

PRIVATE_POOL_PEERING_VPC_NAME=hello-world-cloud-build-central-vpc
RESERVED_RANGE_NAME=private-pool-addresses
#PRIVATE_POOL_NETWORK=192.168.16.0
#PRIVATE_POOL_PREFIX=20
PRIVATE_POOL_NAME=hello-world-private-pool
REGION=us-central1
CLUSTER_CONTROL_PLANE_CIDR=172.16.0.0/28

NETWORK_1=$PRIVATE_POOL_PEERING_VPC_NAME
NETWORK_2=$VPC_NAME

GW_NAME_1=private-peer-gateway
GW_NAME_2=gke-central-gateway
PEER_ASN_1=65001
PEER_ASN_2=65002

IP_ADDRESS_1=169.254.2.1
IP_ADDRESS_2=169.254.3.1
IP_ADDRESS_3=169.254.2.2
IP_ADDRESS_4=169.254.3.2

PEER_IP_ADDRESS_1=$IP_ADDRESS_3
PEER_IP_ADDRESS_2=$IP_ADDRESS_4
PEER_IP_ADDRESS_3=$IP_ADDRESS_1
PEER_IP_ADDRESS_4=$IP_ADDRESS_2

ROUTER_NAME_1=cloud-build-router
ROUTER_1_INTERFACE_NAME_0=cloud-build-interface-if0
ROUTER_1_INTERFACE_NAME_1=cloud-build-interface-if1
TUNNEL_NAME_GW1_IF0=gke-central-tunnel-if0
TUNNEL_NAME_GW1_IF1=gke-central-tunnel-if1
PEER_NAME_GW1_IF0=cloud-build-peer-if0
PEER_NAME_GW1_IF1=cloud-build-peer-if1

ROUTER_NAME_2=gke-central-router
ROUTER_2_INTERFACE_NAME_0=gke-central-interface-if0
ROUTER_2_INTERFACE_NAME_1=gke-central-interface-if1
TUNNEL_NAME_GW2_IF0=cloud-build-tunnel-if0
TUNNEL_NAME_GW2_IF1=cloud-build-tunnel-if1
PEER_NAME_GW2_IF0=gke-central-peer-if0
PEER_NAME_GW2_IF1=gke-central-peer-if1

MASK_LENGTH=30
SHARED_SECRET=$VPN_SHARED_SECRET





variable "iam_secure_tag" {
  type        = string
  description = "Project ID to deploy resources"
  default     = "hr_pplapp"

}



variable "vpc_network_name" {
  type        = string
  description = "VPC network name"
  default     = "vpc-microseg"
}

variable "primary_network_region" {
  type        = string
  description = "Primary network region for micro segmentation architecture"
  default     = "us-west1"
}

variable "primary_network_zone" {
  type        = string
  description = "Primary network zone"
  default     = "us-west1-c"
}


variable "primary_middleware_subnetwork" {
  type        = string
  description = "Subnet range for primary middleware layer"
  default     = "10.30.0.0/28"
}


variable "primary_sub_proxy" {
  type        = string
  description = "Subnet range proxy-only network for internal load balancer"
  default     = "10.31.0.0/26"
}

variable "primary_database_subnetwork" {
  type        = string
  description = "Subnet range for primary middleware layer"
  default     = "10.50.0.0"
}


variable "primary_ilb_ip" {
  type        = string
  description = "IP address for primary region internalload balancer"
  default     = "10.30.0.10"
}


variable "secondary_ilb_ip" {
  type        = string
  description = "IP address for secondary region internal load balancer"
  default     = "10.40.0.10"
}




variable "secondary_network_region" {
  type        = string
  description = "Secondary network region"
  default     = "us-east1"
}

variable "secondary_network_zone" {
  type        = string
  description = "Secondary network zone"
  default     = "us-east1-c"
}



variable "secondary_presentation_subnetwork" {
  type        = string
  description = "Subnet range for secondary presentation layer"
  default     = "10.20.0.0/28"
}

variable "secondary_middleware_subnetwork" {
  type        = string
  description = "Subnet range for secondary middleware layer"
  default     = "10.40.0.0/28"
}

variable "secondary_sub_proxy" {
  type        = string
  description = "Subnet range proxy-only network for internal load balancer"
  default     = "10.41.0.0/26"
}
*/