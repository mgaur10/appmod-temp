# Cloud Security Architecture Application Development DevSecOps Demo


This is not an officially supported Google product documentation.
This code creates a secure demo environment for Vertex AI Workbench. This demo code is not built for production workload. 


# Demo Guide
This demo uses terraform to setup secure Vertex AI Wrokbench network security in a project and underlying infrastructure using Google Cloud Services like  
[Artifact Registry](https://cloud.google.com/artifact-registry), [Assured Open Source Software](https://cloud.google.com/assured-open-source-software), [Binary Authorization](https://cloud.google.com/binary-authorization), [Cloud Build](https://cloud.google.com/build), [Cloud Deploy](https://cloud.google.com/deploy), 
[Cloud Key Management](https://cloud.google.com/kms), [Cloud Compute Engine](https://cloud.google.com/compute), [Containers](https://cloud.google.com/containers), [Datastore](https://cloud.google.com/datastore), [Cloud DNS](https://cloud.google.com/dns), [Cloud Logging](https://cloud.google.com/logging),[Storage](https://cloud.google.com/storage) and [Cloud Workstations](https://cloud.google.com/workstations). 


The infrastructure for this solution aims to create a seamless DevOps pipeline for developers, employing a range of Google Cloud Platform (GCP) services for an integrated development experience. It is designed for Google Cloud customers who operate within an organizational structure that mandates enterprise security measures. This architecture is designed with the following in mind: 
- No internet access for resources
- Full compliance with commonly implemented organizational policies, including but not limited to constraints/compute.vmExternalIpAccess, constraints/compute.requireShieldedVm, and constraints/iam.disableServiceAccountKeyCreation. 
- Compatibility with Shared VPC models, facilitating separation of duties across various departments within your organization
- Compatibility with  VPC Service Controls to mitigate risks associated with sensitive data leakage and unauthorized access
- A least-privilege model through role-based IAM policies
- Short-lived credentials for service account authentication

It is recommended to coordinate with your organization's cloud security team during the deployment phase, particularly if specialized IAM permissions associated with the Compute Network Admin role are required, or if your organization has enabled the constraints/compute.restrictVpnPeerIPs Org policy.

## Demo Architecture Diagram
The image below describes the architecture of CSA Vertex AI Workbench demo to deploy a secure Workbench instance for development purposes.

### Application Development Process Flow Diagram
![Architecture Diagram](./appdev-flowdiagram.png)

### Application Development Technical Architecture Diagram
![Architecture Diagram](./appdev-technicalarch.png)

## What resources are created?
Components to be deployed:
- Project
    - One Google Cloud project will be created to contain all resources within this architecture.
- Region
    - By default, all resources are deployed within us-central1
-  Service Account
    - One service account will be created and used for access to the Assured OSS repository. This service account will be assigned project-level roles for each of the services/resources to be deployed and managed. These roles are assigned using a least-privilege model.
    - Additionally, Cloud Deploy uses the default service compute service account for operations. This service account will be assigned additional roles to accommodate Cloud Build, Artifact Registry, Cloud Logging, and Cloud Storage operations, also using a least-privilege model.
- Cloud DNS
    - This solution enables Private Google Access to allow communication between Google Cloud services and resources within the project, without requiring internet access. Private Google Access requires DNS records to return IP addresses within the private.googleapis.com VIP for the desired Google service domains. These records will need to be created for the services included in this solution, including:
        - *.googleapis.com
        - *.gcr.io
        - *.source.developers.google.com
        -  *.pkg.dev
    - Additionally, a private zone containing one A record is created for the private Cloud Workstation cluster communication with the google-managed private gateway via Private Service Connect endpoint.
- VPC & Subnets
    - This solution uses two VPCs in total. A second VPC (VPC 2: hello-world-cloud-build-central-vpc) is connected to the primary VPC (VPC 1: hello-world-network) via VPN to provide connectivity between the Cloud Build private worker pool and the GKE control plane. The Cloud Build private worker pool and the GKE control plane are placed in separate Google-managed VPCs that are peered to the customer's VPC. This two-VPC design is necessary because the services cannot communicate directly with one another via a single customer VPC due to transitive peering restrictions.
- VPC 1 (hello-world-network) contains:
    - One primary subnet to host the Cloud Workstation instances and the GKE instances, with Private Google Access enabled.
    - Two secondary subnets for the GKE pods and services, respectively.
    - One Private Service Connect endpoint for Cloud Workstation communication to a Google-managed private gateway.
    - One VPC Peering to a Google-managed VPC, also called Service Networking, that contains the GKE control plane.
    - One HA VPN Gateway pair for connectivity to VPC 2. This includes two Cloud Routers to exchange routes between the VPCs via BGP.
    - Default firewall rules
- VPC 2 (hello-world-cloud-build-central-vpc) contains:
    - One VPC Peering to a Google-managed VPC, also called Service Networking, that contains the Cloud Build private pool.
    - One HA VPN Gateway pair for connectivity to VPC 1. This includes two Cloud Routers to exchange routes between the VPCs via BGP.
- Cloud Workstation
    - One workstation cluster using the primary subnet in VPC 1
    - Private endpoint enabled, to ensure only private access to the workstations.
    - One workstation configuration with Shielded VMs enabled
    - Public IPs disabled to prevent workstations from obtaining external IP addresses.
    - One workstation created and launched by default.
- GKE Autopilot Cluster
    - Private cluster
    - Authorized networks enabled - allowing only the primary subnet from VPC 1
- Cloud Source Repository
    - One repository used to clone solution architecture resources, including source code.
- Artifact Registry
    - One Docker repository for storing image artifacts
- Cloud Build worker pool
    - One private worker pool deployed and peered with VPC 2
    - Worker pool configured with no public egress to keep all communications within the VPC
    - Configured to apply one manual attestation for Binary Authorization
- Binary Authorization
    - Enabled and with policy enforcement for the private GKE Autopilot Cluster
    - Two attestors to verify manual attestation and auto “built-by-Cloud-Build” provenance
- Additional Resources
    - Cloud Deploy uses a Cloud Storage bucket to store rendered manifests
    - Cloud Logging is enabled and uses the default configuration of storing admin activity audit logs and system event logs in the project’s logging bucket.



## How to deploy?
The following steps should be executed in Cloud Shell in the Google Cloud Console. 

### 1. IAM Permission 
Grant the user running the terraform below roles.
``` 
Access Context Manager Editor
Billing Account User
Compute Network Admin
DNS Administrator
Folder Creator
Organization Policy Administrator
Project Creator
```


### 2. Get the code
Clone this github repository go to the root of the repository.

``` 
git clone https://github.com/GCP-Architecture-Guides/CSA-App-Dev.git
cd CSA-App-Dev
```

### 3. Deploy the infrastructure using Terraform


From the root folder of this repo, run the following commands:

```
export TF_VAR_organization_id=[YOUR_ORGANIZATION_ID]
export TF_VAR_billing_account=[YOUR_BILLING_ID]
export TF_VAR_end_user_account=["user:NAME1@DOMAIN.com"]
export TF_VAR_instance_owners=["NAME1@DOMAIN.com"]
export TF_VAR_firewall_ips_enabled = [false] ## Default is false; set it to 'true' to enable firewall+ resources
terraform init
terraform apply
terraform apply --refresh-only
```

To find your organization id, run the following command: 
```
gcloud projects get-ancestors [ANY_PROJECT_ID]
```


**Note:** All the other variables are give a default value. If you wish to change, update the corresponding variables in variable.tf file.



## How to clean-up?

From the root folder of this repo, run the following command:
```
terraform destroy
```
**Note:** If you get an error while destroying, it is likely due to delay in VPC-SC destruction rollout. Just execute terraform destroy again, to continue clean-up.


## Deployment Duration
Configuration: X mins
Deployment: Y mins


## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
