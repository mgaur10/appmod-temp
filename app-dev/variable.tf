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
}

variable "billing_account" {
  type        = string
  description = "billing account required"
}

variable "project_name" {
  type        = string
  description = "Project ID to deploy resources"
}

variable "developer_service_account" {
  type        = string
  description = "inner/outer dev loop service agent"
}

variable "folder_name" {
  type        = string
  default     = "CSA-AppDev-2"
  description = "A folder to create this project under. If none is provided, the project will be created under the organization"
}



variable "skip_delete" {
  description = " If true, the Terraform resource can be deleted without deleting the Project via the Google API."

}

variable "workstation_private_config" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = bool
default     = false
}



variable "end_user_account" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = string
}



variable "developer_roles" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = list(string)
}



variable "end_user_roles" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = list(string)
}


variable "compute_default_roles" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = list(string)
}


variable "vpc_network_name" {
  type        = string
  description = "VPC network name"
}


variable "vpc_subnetwork_name" {
  type        = string
  description = "VPC subnetwork name"
}

variable "network_region" {
  type        = string
  description = "Primary network region for micro segmentation architecture"
}

variable "network_zone" {
  type        = string
  description = "Primary network zone"
}


variable "ip_subnetwork_cidr_primary" {
  type        = string
  description = "Subnet range for primary presentation layer"
}


variable "ip_subnetwork_cidr_pod_range" {
  type        = string
  description = "Subnet range for primary presentation layer"
}

variable "ip_subnetwork_cidr_service_range" {
  type        = string
  description = "Subnet range for primary presentation layer"
}


variable "gke_subnetwork_master_cidr_range" {
  type        = string
  description = "Subnet range for primary presentation layer"
}




variable "git_user_account" {
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
  type        = string
}

variable "git_user_email" {
  type        = string
  description = "User email for Git"
}

variable "git_user_name" {
  type        = string
  description = "User name for Git"
}


variable "gke_cluster_name" {
  type        = string
  description = "GKE_CLUSTER_NAME"
  default     = "hello-world-cluster"
}

variable "private_pool_peering_vpc_name" {
  type        = string
  description = "PRIVATE_POOL_PEERING_VPC_NAME"
  default     = "hello-world-cloud-build-central-vpc"
}


variable "reserved_range_name" {
  type        = string
  description = "RESERVED_RANGE_NAME"
  default     = "private-pool-addresses"
}

#RESERVED_RANGE_NAME=private-pool-addresses #

variable "private_pool_network" {
  type        = string
  description = "PRIVATE_POOL_NETWORK"
  default     = "192.168.16.0"
}
# PRIVATE_POOL_NETWORK=192.168.16.0 #

variable "private_pool_prefix" {
  type        = string
  description = "PRIVATE_POOL_PREFIX"
  default     = "20"
}

#PRIVATE_POOL_PREFIX=20 #


variable "private_pool_name" {
  type        = string
  description = "PRIVATE_POOL_NAME"
  default     = "hello-world-private-pool"
}
#PRIVATE_POOL_NAME=hello-world-private-pool #

variable "gw_name_1" {
  type        = string
  description = "GW_NAME_1"
  default     = "private-peer-gateway"
}

# GW_NAME_1=private-peer-gateway #

variable "gw_name_2" {
  type        = string
  description = "GW_NAME_2"
  default     = "gke-central-gateway"
}

#GW_NAME_2=gke-central-gateway #

variable "peer_asn_1" {
  type        = number
  description = "PEER_ASN_1"
  default     = 65001
}

# PEER_ASN_1=65001 #

variable "peer_asn_2" {
  type        = number
  description = "PEER_ASN_2"
  default     = 65002
}

#PEER_ASN_2=65002 #

variable "ip_address_1" {
  type        = string
  description = "PEER_IP_ADDRESS_3=$IP_ADDRESS_1"
  default     = "169.254.2.1"
}

# IP_ADDRESS_1=169.254.2.1 #

variable "ip_address_2" {
  type        = string
  description = "PEER_IP_ADDRESS_4=$IP_ADDRESS_2"
  default     = "169.254.3.1"
}

# IP_ADDRESS_2=169.254.3.1 #

variable "ip_address_3" {
  type        = string
  description = "PEER_IP_ADDRESS_1=$IP_ADDRESS_3"
  default     = "169.254.2.2"
}


# IP_ADDRESS_3=169.254.2.2 #

variable "ip_address_4" {
  type        = string
  description = "PEER_IP_ADDRESS_2=$IP_ADDRESS_4"
  default     = "169.254.3.2"
}

#IP_ADDRESS_4=169.254.3.2 #

#PEER_IP_ADDRESS_1=$IP_ADDRESS_3
#PEER_IP_ADDRESS_2=$IP_ADDRESS_4
#PEER_IP_ADDRESS_3=$IP_ADDRESS_1
#PEER_IP_ADDRESS_4=$IP_ADDRESS_2

variable "router_name_1" {
  type        = string
  description = "ROUTER_NAME_1"
  default     = "cloud-build-router"
}

#ROUTER_NAME_1=cloud-build-router #

variable "router_1_interface_name_0" {
  type        = string
  description = "ROUTER_1_INTERFACE_NAME_0"
  default     = "cloud-build-interface-if0"
}

#ROUTER_1_INTERFACE_NAME_0=cloud-build-interface-if0 #

variable "router_1_interface_name_1" {
  type        = string
  description = "ROUTER_1_INTERFACE_NAME_1"
  default     = "cloud-build-interface-if1"
}

# ROUTER_1_INTERFACE_NAME_1=cloud-build-interface-if1 #

variable "tunnel_name_gw1_if0" {
  type        = string
  description = "TUNNEL_NAME_GW1_IF0"
  default     = "gke-central-tunnel-if0"
}

#TUNNEL_NAME_GW1_IF0=gke-central-tunnel-if0 #

variable "tunnel_name_gw1_if1" {
  type        = string
  description = "TUNNEL_NAME_GW1_IF1"
  default     = "gke-central-tunnel-if1"
}

# TUNNEL_NAME_GW1_IF1=gke-central-tunnel-if1 #

variable "peer_name_gw1_if0" {
  type        = string
  description = "PEER_NAME_GW1_IF0"
  default     = "cloud-build-peer-if0"
}

# PEER_NAME_GW1_IF0=cloud-build-peer-if0 #

variable "peer_name_gw1_if1" {
  type        = string
  description = "PEER_NAME_GW1_IF1"
  default     = "cloud-build-peer-if1"
}

# PEER_NAME_GW1_IF1=cloud-build-peer-if1 #

variable "router_name_2" {
  type        = string
  description = "ROUTER_NAME_2"
  default     = "gke-central-router"
}
# ROUTER_NAME_2=gke-central-router #

variable "router_2_interface_name_0" {
  type        = string
  description = "ROUTER_2_INTERFACE_NAME_0"
  default     = "gke-central-interface-if0"
}

# ROUTER_2_INTERFACE_NAME_0=gke-central-interface-if0 #

variable "router_2_interface_name_1" {
  type        = string
  description = "ROUTER_2_INTERFACE_NAME_1"
  default     = "gke-central-interface-if1"
}

# ROUTER_2_INTERFACE_NAME_1=gke-central-interface-if1 #

variable "tunnel_name_gw2_if0" {
  type        = string
  description = "TUNNEL_NAME_GW2_IF0"
  default     = "cloud-build-tunnel-if0"
}

# TUNNEL_NAME_GW2_IF0=cloud-build-tunnel-if0 #

variable "tunnel_name_gw2_if1" {
  type        = string
  description = "TUNNEL_NAME_GW2_IF1"
  default     = "cloud-build-tunnel-if1"
}

# TUNNEL_NAME_GW2_IF1=cloud-build-tunnel-if1 #

variable "peer_name_gw2_if0" {
  type        = string
  description = "PEER_NAME_GW2_IF0"
  default     = "gke-central-peer-if0"
}

# PEER_NAME_GW2_IF0=gke-central-peer-if0 #

variable "peer_name_gw2_if1" {
  type        = string
  description = "PEER_NAME_GW2_IF1"
  default     = "gke-central-peer-if1"
}

# PEER_NAME_GW2_IF1=gke-central-peer-if1 #

variable "mask_length" {
  type        = number
  description = "MASK_LENGTH"
  default     = 30
}

# MASK_LENGTH=30 #
/*
# Project ID of the project containing the Private GKE Cluster
GKE_CLUSTER_PROJECT=$PROJECT_ID
# Private GKE Cluster for deployment
GKE_CLUSTER_NAME=hello-world-cluster #
# VPC used for the Private GKE cluster
VPC_NAME=hello-world-network

VPC_HOST_PROJECT="$GKE_CLUSTER_PROJECT" 
VPC_HOST_PROJECT_NUMBER="$(gcloud projects describe $VPC_HOST_PROJECT --format 'value(projectNumber)')" 
# --- End Vars for local script

PRIVATE_POOL_PEERING_VPC_NAME=hello-world-cloud-build-central-vpc #
RESERVED_RANGE_NAME=private-pool-addresses #
PRIVATE_POOL_NETWORK=192.168.16.0 #
PRIVATE_POOL_PREFIX=20 #
PRIVATE_POOL_NAME=hello-world-private-pool #
REGION=us-central1
CLUSTER_CONTROL_PLANE_CIDR=172.16.0.0/28

NETWORK_1=$PRIVATE_POOL_PEERING_VPC_NAME
NETWORK_2=$VPC_NAME

GW_NAME_1=private-peer-gateway #
GW_NAME_2=gke-central-gateway #
PEER_ASN_1=65001 #
PEER_ASN_2=65002 #

IP_ADDRESS_1=169.254.2.1 #
IP_ADDRESS_2=169.254.3.1 #
IP_ADDRESS_3=169.254.2.2 #
IP_ADDRESS_4=169.254.3.2 #

PEER_IP_ADDRESS_1=$IP_ADDRESS_3
PEER_IP_ADDRESS_2=$IP_ADDRESS_4
PEER_IP_ADDRESS_3=$IP_ADDRESS_1
PEER_IP_ADDRESS_4=$IP_ADDRESS_2

ROUTER_NAME_1=cloud-build-router #
ROUTER_1_INTERFACE_NAME_0=cloud-build-interface-if0 #
ROUTER_1_INTERFACE_NAME_1=cloud-build-interface-if1 #
TUNNEL_NAME_GW1_IF0=gke-central-tunnel-if0 #
TUNNEL_NAME_GW1_IF1=gke-central-tunnel-if1 #
PEER_NAME_GW1_IF0=cloud-build-peer-if0 #
PEER_NAME_GW1_IF1=cloud-build-peer-if1 #

ROUTER_NAME_2=gke-central-router #
ROUTER_2_INTERFACE_NAME_0=gke-central-interface-if0 #
ROUTER_2_INTERFACE_NAME_1=gke-central-interface-if1 #
TUNNEL_NAME_GW2_IF0=cloud-build-tunnel-if0 #
TUNNEL_NAME_GW2_IF1=cloud-build-tunnel-if1 #
PEER_NAME_GW2_IF0=gke-central-peer-if0 #
PEER_NAME_GW2_IF1=gke-central-peer-if1 #

MASK_LENGTH=30 #
SHARED_SECRET=$VPN_SHARED_SECRET

*/



#### Attestor
variable "kms_keyring_name" {
  type        = string
  description = "kms keyring name"
  default     = "hello-world-keyring1"
}

variable "kms_key_name" {
  type        = string
  description = "kms key name"
  default     = "hello-world-key1"
}

variable "kms_key_version" {
  type        = number
  description = "kms key version"
  default     = 1
}

variable "kms_key_purpose" {
  type        = string
  description = "kms key purpose"
  default     = "ASYMMETRIC_SIGN"
}


variable "kms_key_algorithm" {
  type        = string
  description = "kms key algorithm"
  default     = "EC_SIGN_P256_SHA256"
}

variable "kms_protection_level" {
  type        = string
  description = "kms protection level"
  default     = "software"
}


variable "note_id" {
  type        = string
  description = "hello world attestor note"
  default     = "hello-world-attestor-note"
}

variable "note_description" {
  type        = string
  description = "attestor note description for the spring hello world java app"
  default     = "attestor note for the spring hello world java app"
}

variable "attestor_name" {
  type        = string
  description = "attestor name"
  default     = "hello-world-attestor"
}
/*
KMS_KEY_PROJECT_ID=$PROJECT_ID
KMS_KEY_LOCATION=us-central1
#KMS_KEYRING_NAME=hello-world-keyring
#KMS_KEY_NAME=hello-world-key
#KMS_KEY_VERSION=1
#KMS_KEY_PURPOSE=asymmetric-signing
#KMS_KEY_ALGORITHM=ec-sign-p256-sha256
#KMS_PROTECTION_LEVEL=software
NOTE_ID=hello-world-attestor-note
NOTE_URI="projects/${ATTESTOR_PROJECT_ID}/notes/${NOTE_ID}"
DESCRIPTION="Attestor note for the Spring Hello World Java app"
ATTESTOR_NAME=hello-world-attestor
*/







/*
  _IMAGE_NAME_AND_TAGS: "<provided at build submit time>"
  _DELIVERY_PIPELINE_NAME: "$DELIVERY_PIPELINE_NAME"
  _DOCKER_REPO_NAME: "$DOCKER_REPO_NAME"
  _DOCKER_REPO_URL: "${LOCATION}-docker.pkg.dev/${PROJECT_ID}/${_DOCKER_REPO_NAME}"
  _PRIVATE_WORKER_POOL: "$PRIVATE_WORKER_POOL"
  _ATTESTOR_NAME: "$ATTESTOR_NAME"
  _KMS_KEYRING_NAME: "$KMS_KEYRING_NAME"
  _KMS_KEY_NAME: "$KMS_KEY_NAME"
  _KMS_KEY_VERSION: "KMS_KEY_VERSION"
  _MVN_VERSION: "3.8.7"
  _SKAFFOLD_VERSION: "v2.6.0"
  _MVN_URL: "https://us-maven.pkg.dev/cloud-aoss/java/org/apache/maven/apache-maven/${_MVN_VERSION}/apache-maven-${_MVN_VERSION}-bin.zip"
  _SKAFFOLD_URL: "https://storage.googleapis.com/skaffold/releases/${_SKAFFOLD_VERSION}/skaffold-linux-amd64"
  _TOKEN_URL: "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token"
  _WORKER_SERVICE_ACCOUNT: "$SERVICE_ACCOUNT"
*/