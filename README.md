# terraform-google-simple-module

## Description
### Tagline
This is an auto-generated module.

### Detailed
This module was generated from [terraform-google-module-template](https://github.com/terraform-google-modules/terraform-google-module-template/), which by default generates a module that simply creates a GCS bucket. As the module develops, this README should be updated.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a GCS bucket with the provided name

### PreDeploy
To deploy this blueprint you must have an active billing account and billing permissions.

## Architecture
![alt text for diagram](https://www.link-to-architecture-diagram.com)
1. Architecture description step no. 1
2. Architecture description step no. 2
3. Architecture description step no. N

## Documentation

TODO: Insert documentation for all steps up to 'terraform apply'

You may now begin to use your Secure Development Environment

1. Open the Google Cloud Console through a web browser and navigate to the [Cloud Workstations page](https://console.cloud.google.com/workstations/list)
2. Navigate to you Cloud Workstation (named 'hello-world-worksation' be default) and click the 'Launch' button. Note: If you see the 'Start' button instead of 'Launch', click the 'Start' button and then click the 'Launch' button once it becomes available.
  ![Screenshot 2023-11-03 12 49 46 PM](https://github.com/mgaur10/appmod-temp/assets/38972/61aac3fa-f492-41e0-82f8-91d4e4b4b79c)
4. You should now be in a new browser tab viewing your 'Code OSS' IDE.
  ![Screenshot 2023-11-02 9 29 16 PM](https://github.com/mgaur10/appmod-temp/assets/38972/e65eab05-9642-4b74-890b-0ad6daf517db)
5. Click the menu 'File -> Open Folder -> hello_word_java' to open your Java Sample Application project directory
  ![Screenshot 2023-11-02 9 30 10 PM](https://github.com/mgaur10/appmod-temp/assets/38972/d618f3c3-4cad-4547-bc20-69d20593070f)
6. Click the menu 'Terminal -> New Terminal'
  ![Screenshot 2023-11-02 9 30 54 PM](https://github.com/mgaur10/appmod-temp/assets/38972/7bbf23b9-c95f-4d3c-a24c-31efd46abc9e)
8. You should see messages about Maven installation, Minikube starting, and Skaffold starting
10. Authorize your end-user account to the Workstation 'gcloud' cli in the terminal: `gcloud auth login`, and follow the steps to sign in.
11. Verify that the sample application is running and responding to requests
    * View the Skaffold logs and ensure that the service is running: `tail -f /var/log/skaffold.log` 
    * You should see a similar message towards the end of the logs: "Started HelloWorldApplication in 3.195 seconds"
    * Send a request to the Java application from the Cloud Workstation terminal to the Minikube cluster: `curl http://localhost:9000`. 
    * NOTE: Skaffold is configured to forward port 9000 to your local Minikube k8s service. You may also click the hyperlink generated in your Cloud Workstation terminal from the 'http://localhost:9000' and view the application response in your web browser.
12. Make a code change, commit, and push to the remote repository
    * Open 'src/main/java/com/example/helloWorld/HelloWorldApplication.java' in your Cloud Workstation IDE and change the "Hello World" string to something different.
13. Commit and push your changes to the remote repository: `git add src && git commit -m "first custom commit" && git push`.
    * Note: Your repository is configured to use your 'gcloud' credentials to authenticate with the remote Cloud Source Repository. If there is an authentication problem, you may have forgotten to run `gcloud auth login` as described above.
14. Navigate to Cloud Build and verify that your 'Outer Dev Loop' build pipeline has completed successfully.
  ![Screenshot 2023-11-03 12 55 51 PM](https://github.com/mgaur10/appmod-temp/assets/38972/6e2a31f2-8bc9-4b64-90be-4d65edc2a2b3)
  * NOTE: There will be a total of 4 Builds that need to be successful: 1 that is triggered is declared in your Cloud Build Trigger, 1 that is submitted by the Build called from your Cloud Build Trigger, 2 that are submitted automatically by Cloud Deploy for your new release (that call the skaffold 'render' and 'deploy' stages).
16. When the Cloud Build steps have completed successfully, validate that your application can receive requests from your Cloud Workstations.
    * Set your k8s configuration to reference your remote GKE Cluster: `gcloud container clusters get-credentials hello-world-cluster --region us-central1`
    * Open a tunnel via port-forwarding from your Cloud Workstation to your GKE Service: `kubectl port-forward services/spring-java-hello-world-service 9090:8080`
    * Send a request to the Java application from the Cloud Workstation terminal to the Minikube cluster: `curl http://localhost:9090`.  You may also click the hyperlink generated in your Cloud Workstation terminal from the 'http://localhost:9090' and view the application response in your web browser.
17. When finishing testing your remote cluster, set your local k8s configuration back to Minikube for further dev work: `kubectl config use-context minikube`

## Deployment Duration
Configuration: X mins
Deployment: Y mins

## Cost
[Blueprint cost details](https://cloud.google.com/products/calculator?id=02fb0c45-cc29-4567-8cc6-f72ac9024add)

## Usage

Basic usage of this module is as follows:

```hcl
module "simple_module" {
  source  = "terraform-google-modules/simple-module/google"
  version = "~> 0.1"

  project_id  = "<PROJECT ID>"
  bucket_name = "gcs-test-bucket"
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name | The name of the bucket to create | `string` | n/a | yes |
| project\_id | The project ID to deploy to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_name | Name of the bucket |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Storage Admin: `roles/storage.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
