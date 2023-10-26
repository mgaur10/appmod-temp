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

gcloud kms keyrings create ${KMS_KEYRING_NAME} \
    --location ${KMS_KEY_LOCATION}

gcloud kms keys create ${KMS_KEY_NAME} \
    --location ${KMS_KEY_LOCATION} \
    --keyring ${KMS_KEYRING_NAME}  \
    --purpose ${KMS_KEY_PURPOSE} \
    --default-algorithm ${KMS_KEY_ALGORITHM} \
    --protection-level ${KMS_PROTECTION_LEVEL}


*/
resource "google_kms_key_ring" "kms_keyring" {
  name     = var.kms_keyring_name
  location = var.network_region
  project  = google_project.app_dev_project.project_id

depends_on = [
time_sleep.wait_for_org_policy
]  

}



resource "google_kms_crypto_key" "signing_key" {
  name     = var.kms_key_name
  key_ring = google_kms_key_ring.kms_keyring.id
  purpose  = var.kms_key_purpose
  #    project  = google_project.app_dev_project.project_id


  version_template {
    algorithm        = var.kms_key_algorithm
  #  protection_level = var.kms_protection_level
  }

  lifecycle {
    prevent_destroy = false
  }

  depends_on = [
google_kms_crypto_key.signing_key
]  

}


resource "google_container_analysis_note" "note" {
  name    = var.note_id
  project = google_project.app_dev_project.project_id

  short_description = var.note_description
  long_description  = var.note_description
  #  expiration_time = "2120-10-02T15:01:23.045123456Z"

  /*
  related_url {
    url = "some.url"
    label = "foo"
  }

  related_url {
    url = "google.com"
  }
*/
  attestation_authority {
    hint {
      human_readable_name = var.note_description
    }
  }
  depends_on = [
time_sleep.wait_for_org_policy,
]  
  
}


/*

gcloud --project="${ATTESTOR_PROJECT_ID}" \
    container binauthz attestors create "${ATTESTOR_NAME}" \
    --attestation-authority-note="${NOTE_ID}" \
    --attestation-authority-note-project="${ATTESTOR_PROJECT_ID}"

gcloud --project="${ATTESTOR_PROJECT_ID}" \
    container binauthz attestors public-keys add \
    --attestor="${ATTESTOR_NAME}" \
    --keyversion-project="${KMS_KEY_PROJECT_ID}" \
    --keyversion-location="${KMS_KEY_LOCATION}" \
    --keyversion-keyring="${KMS_KEYRING_NAME}" \
    --keyversion-key="${KMS_KEY_NAME}" \
    --keyversion="${KMS_KEY_VERSION}"
*/

data "google_kms_crypto_key_version" "signing_key_version" {
  crypto_key = google_kms_crypto_key.signing_key.id
  #    project  = google_project.app_dev_project.project_id

  depends_on = [
google_kms_crypto_key.signing_key
]  

}

resource "google_binary_authorization_attestor" "attestor" {
  name    = var.attestor_name
  project = google_project.app_dev_project.project_id
  attestation_authority_note {
    note_reference = google_container_analysis_note.note.name
    public_keys {
      id = data.google_kms_crypto_key_version.signing_key_version.id
      pkix_public_key {
        public_key_pem      = data.google_kms_crypto_key_version.signing_key_version.public_key[0].pem
        signature_algorithm = data.google_kms_crypto_key_version.signing_key_version.public_key[0].algorithm
      }
    }
  }

  depends_on = [
data.google_kms_crypto_key_version.signing_key_version,
google_container_analysis_note.note,
]  
}

/*
resource "google_binary_authorization_policy" "bi_auth_policy" {
  project     = google_project.app_dev_project.project_id
  description = "Bi authorization policy"
  default_admission_rule {
    evaluation_mode         = "REQUIRE_ATTESTATION"
    enforcement_mode        = "ENFORCED_BLOCK_AND_AUDIT_LOG"
    require_attestations_by = [google_binary_authorization_attestor.attestor.name, "projects/${google_project.app_dev_project.project_id}/attestors/built-by-cloud-build"]
  }

  global_policy_evaluation_mode = "ENABLE"

  depends_on = [
    google_binary_authorization_attestor.attestor,
  ]
}
*/