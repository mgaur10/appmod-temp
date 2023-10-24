



resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.network_region
  repository_id = "hello-world-docker-repository"
  description   = "Sample Hello World Docker repo"
  format        = "DOCKER"
  project       = google_project.app_dev_project.project_id
}



resource "google_sourcerepo_repository" "my-repo" {
  name = "hello-world-java"
  project       = google_project.app_dev_project.project_id
}







/*
resource "null_resource" "repo_setup" {
  triggers = {
    always_run = "${timestamp()}"
  }
    
  provisioner "local-exec" {
#interpreter = ["bash", "-c"]
    command = <<-EOT
    gcloud config set project ${google_project.app_dev_project.project_id}
    gcloud source repos create hello-world-java
    gcloud source repos clone hello-world-java
    git config --global user.email "${var.git_user_email}"
    git config --global user.name "${var.git_user_name}"
    pushd .
    cd springboard-java-hello-world
    git checkout main
    popd
    cp -r springboard-java-hello-world/* \
      springboard-java-hello-world/.mvn \
      springboard-java-hello-world/.gitignore \
      hello-world-java/
    cd hello-world-java
    git add .
    git commit -m "first commit"
    git push origin master
    




    gcloud workstations start ${google_workstations_workstation.hello_world_workstation.workstation_id} --region ${var.network_region} --cluster ${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config workstation-config
gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} --command= <<-EOT1
sudo cat <<-EOF > custom.sh
gcloud config set project ${google_project.app_dev_project.project_id} 
gcloud config set account ${var.git_user_account}
export CLOUDSDK_AUTH_ACCESS_TOKEN=${data.local_file.cloud_sdk_token.content}
export GOOGLE_OAUTH_ACCESS_TOKEN=${data.local_file.google_oauth_token.content}
gcloud source repos create hello-world-java
gcloud source repos clone hello-world-java
git config --global user.email "${var.git_user_email}"
git config --global user.name "${var.git_user_name}"
gcloud source repos clone springboard-java-hello-world --project springboard-dev-env
pushd .
cd springboard-java-hello-world
git checkout main
popd
cp -r springboard-java-hello-world/* \
      springboard-java-hello-world/.mvn \
      springboard-java-hello-world/.gitignore \
      hello-world-java/
cd hello-world-java
git add .
git commit -m "first commit"
git push origin master
export PROJECT_HOME=/home/user/hello-world-java
export SERVICE_ACCOUNT=${google_service_account.developer_service_account.email}
EOF
EOT1
    EOT
    
  }
  depends_on = [google_workstations_workstation.hello_world_workstation,
  data.local_file.google_oauth_token,
    data.local_file.cloud_sdk_token,
  ]
}




*/



/*
user@hello-world-workstation:~/hello-world-java$ skaffold dev -f ${PROJECT_HOME}/skaffold.yaml -p dev 

resource "null_resource" "cloud_sdk_token" {
  triggers = {
    always_run = "${timestamp()}"
    token = "$(gcloud auth print-access-token)"
  }
    
  provisioner "local-exec" {
    command = <<EOF
   echo ${self.triggers.token} > cloud_sdk_token.txt
    EOF
  }
  depends_on = [google_workstations_workstation.hello_world_workstation]
}



 data "local_file" "cloud_sdk_token" {
    filename = "cloud_sdk_token.txt"
    depends_on = [null_resource.cloud_sdk_token]
    }


resource "null_resource" "google_oauth_token" {
  triggers = {
    always_run = "${timestamp()}"
    token = "$(gcloud auth print-access-token --impersonate-service-account=${google_service_account.developer_service_account.email} --verbosity=error)"
  }
    
  provisioner "local-exec" {
    command = <<EOF
   echo ${self.triggers.token} > google_oauth_token.txt
    EOF
  }
  depends_on = [google_workstations_workstation.hello_world_workstation]
}



 data "local_file" "google_oauth_token" {
    filename = "google_oauth_token.txt"
    depends_on = [null_resource.google_oauth_token]
    }


resource "null_resource" "start_workstaion" {
  triggers = {
    always_run = "${timestamp()}"
  }
    
  provisioner "local-exec" {
#interpreter = ["bash", "-c"]
    command = <<-EOT
    gcloud config set project ${google_project.app_dev_project.project_id}
    gcloud workstations start ${google_workstations_workstation.hello_world_workstation.workstation_id} --region ${var.network_region} --cluster ${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config workstation-config
gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} --command= <<-EOT1
sudo cat <<-EOF > custom.sh
gcloud config set project ${google_project.app_dev_project.project_id} 
gcloud config set account ${var.git_user_account}
export CLOUDSDK_AUTH_ACCESS_TOKEN=${data.local_file.cloud_sdk_token.content}
export GOOGLE_OAUTH_ACCESS_TOKEN=${data.local_file.google_oauth_token.content}
gcloud source repos create hello-world-java
gcloud source repos clone hello-world-java
git config --global user.email "${var.git_user_email}"
git config --global user.name "${var.git_user_name}"
gcloud source repos clone springboard-java-hello-world --project springboard-dev-env
pushd .
cd springboard-java-hello-world
git checkout main
popd
cp -r springboard-java-hello-world/* \
      springboard-java-hello-world/.mvn \
      springboard-java-hello-world/.gitignore \
      hello-world-java/
cd hello-world-java
git add .
git commit -m "first commit"
git push origin master
export PROJECT_HOME=/home/user/hello-world-java
export SERVICE_ACCOUNT=${google_service_account.developer_service_account.email}
EOF
EOT1
    EOT
    
  }
  depends_on = [google_workstations_workstation.hello_world_workstation,
  data.local_file.google_oauth_token,
    data.local_file.cloud_sdk_token,
  ]
}

#export CLOUDSDK_AUTH_ACCESS_TOKEN=${data.local_file.cloud_sdk_token.content}
#export GOOGLE_OAUTH_ACCESS_TOKEN=${data.local_file.google_oauth_token.content}

resource "null_resource" "start_up_script" {
  triggers = {
    always_run = "${timestamp()}"
  }
    
  provisioner "local-exec" {
#interpreter = ["bash", "-c"]
    command = <<-EOT
gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} --command= <<-EOT1
chmod 777 custom.sh
./custom.sh
cd hello-world-java
./installer.sh
source ~/.hello-world-dev-config ${google_service_account.developer_service_account.email} /home/user/hello-world-java
EOT1
    EOT
    
  }
  depends_on = [null_resource.start_workstaion,
  ]
}

*/

#     gcloud workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} -- 'gcloud config set project ${google_project.app_dev_project.project_id};gcloud config set account ${var.git_user_account};export CLOUDSDK_AUTH_ACCESS_TOKEN=${data.local_file.token.content};gcloud source repos create tmp-hello-world-java;gcloud source repos clone tmp-hello-world-java;'
#    gcloud config unset project
# gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} --command= <<EOT

#  gcloud config set project ${google_project.app_dev_project.project_id} 


#    sleep 5
#    echo "test 1"
#    gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} -- 'gcloud config set project ${google_project.app_dev_project.project_id} && gcloud source repos create hello-world-java --project=${google_project.app_dev_project.project_id} --access-token-file=/home/user/token.txt'
#    sleep 5

/*
resource "google_sourcerepo_repository" "hello_world_java" {
  name = "hello-world-java"
project       = google_project.app_dev_project.project_id
}


resource "null_resource" "workstaion_update" {
  triggers = {
    always_run = "${timestamp()}"
  }
    
  provisioner "local-exec" {
interpreter = ["bash", "-c"]
command =  <<-EOT1
gcloud workstations start ${google_workstations_workstation.hello_world_workstation.workstation_id} --region ${var.network_region} --cluster ${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config workstation-config --project=${google_project.app_dev_project.project_id}
gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} --command= <<-EOT2
sudo cat <<-EOF > custom.sh
gcloud source repos clone hello-world-java --project=${google_project.app_dev_project.project_id}
git config --global user.email "${var.git_user_email}"
git config --global user.name "${var.git_user_name}"
gcloud source repos clone springboard-java-hello-world --project springboard-dev-env 
pushd . 
cd springboard-java-hello-world 
git checkout main 
popd 
cp -r springboard-java-hello-world/* springboard-java-hello-world/.mvn springboard-java-hello-world/.gitignore hello-world-java/ 
cd hello-world-java 
git add . 
git commit -m "first commit" 
git push origin master
export SERVICE_ACCOUNT=${google_service_account.developer_service_account.email}
export PROJECT_HOME=/home/user/hello-world-java
./installer.sh
source ~/.hello-world-dev-config ${google_service_account.developer_service_account.email} /home/user/hello-world-java
skaffold dev -f /home/user/hello-world-java/skaffold.yaml -p dev
EOT1
  }
  depends_on = [google_workstations_workstation.hello_world_workstation,
#  data.local_file.token,
#  null_resource.start_workstaion,
  ]
}

# /home/user/token.txt


#gcloud workstations stop ${google_workstations_workstation.hello_world_workstation.workstation_id} --region ${var.network_region} --cluster ${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config workstation-config --project=${google_project.app_dev_project.project_id} 
#    sleep 5
#    echo "workstation stop"
#    gcloud workstations start ${google_workstations_workstation.hello_world_workstation.workstation_id} --region ${var.network_region} --cluster ${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config workstation-config --project=${google_project.app_dev_project.project_id} 
#    sleep 5
#    echo "workstation start"

# echo "test 2"
#    gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} -- 'gcloud config set project ${google_project.app_dev_project.project_id} && gcloud source repos create hello-world-java --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt && gcloud source repos clone hello-world-java --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt && git config --global user.email "manishgaur.cs@gmail.com" --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt && git config --global user.name "Manish Gaur" --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt && gcloud source repos clone springboard-java-hello-world --project=springboard-dev-env --access-token-file=token.txt && pushd . '
#    sleep 5
#    echo "test 3"
#    gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} -- 'gcloud config set project ${google_project.app_dev_project.project_id} && cp token.txt springboard-java-hello-world/token.txt && cd springboard-java-hello-world --access-token-file=token.txt && git checkout main --access-token-file=token.txt && popd --access-token-file=token.txt && cp -r springboard-java-hello-world/* springboard-java-hello-world/.mvn springboard-java-hello-world/.gitignore hello-world-java/ --access-token-file=token.txt && cp token.txt hello-world-java/token.txt && cd hello-world-java --access-token-file=token.txt && git add . --access-token-file=token.txt && git commit -m "first commit" --access-token-file=token.txt && git push origin master --access-token-file=token.txt '
#    sleep 5
#    echo "test 4"
# && gcloud source repos clone hello-world-java --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt && git config --global user.email "manishgaur.cs@gmail.com" --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt && git config --global user.name "Manish Gaur" --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt



 #gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} -- 'gcloud source repos create hello-world-java --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt && gcloud source repos clone hello-world-java --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt && git config --global user.email "manishgaur.cs@gmail.com" --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt && git config --global user.name "Manish Gaur" --project=${google_project.app_dev_project.project_id} --access-token-file=token.txt'
 #   sleep 15
 #   gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=workstation-config --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} -- 'gcloud source repos clone springboard-java-hello-world --project springboard-dev-env --access-token-file=token.txt && pushd . && cd springboard-java-hello-world && git checkout main && popd && cp -r springboard-java-hello-world/* springboard-java-hello-world/.mvn springboard-java-hello-world/.gitignore hello-world-java/ && cd hello-world-java && git add . && git commit -m "first commit" && git push origin master'
    

#  
    
# echo ${data.local_file.token.content} && 
#    echo "token ${self.triggers.token}"
#echo $REFRESH_TOKEN && echo $REFRESH_TOKEN >> token.txt && gcloud source repos create hello-world-java-token --project=csa-app-dev-9ee2e8f7 --access-token-file=/home/user/token.txt
# gcloud beta workstations ssh --project=${google_project.app_dev_project.project_id} --cluster=${google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id} --config=${google_workstations_workstation_config.workstation_cluster_config_2.workstation_config_id} --region=${var.network_region} ${google_workstations_workstation.hello_world_workstation.workstation_id} -- ' && gcloud source repos create hello-world-java && gcloud source repos clone hello-world-java && git config --global user.email "admin@manishkgaur.altostrat.com" && git config --global user.name "Manish Gaur" && gcloud source repos clone springboard-java-hello-world --project springboard-dev-env && pushd . && cd springboard-java-hello-world && git checkout main && popd && cp -r springboard-java-hello-world/* springboard-java-hello-world/.mvn springboard-java-hello-world/.gitignore hello-world-java/ && cd hello-world-java && git add . && git commit -m "first commit" && ./installer.sh && export PROJECT_HOME=/home/user/hello-world-java && export SERVICE_ACCOUNT=${google_service_account.developer_service_account.email} && source ~/.hello-world-dev-config $SERVICE_ACCOUNT $PROJECT_HOME'


*/

/*
resource "google_workstations_workstation_config" "workstation_cluster_config_2" {
  provider               = google-beta
  workstation_config_id  = "workstation-config-2"
  workstation_cluster_id = google_workstations_workstation_cluster.workstation_cluster.workstation_cluster_id
  location                    = var.network_region
  project       = google_project.app_dev_project.project_id

  idle_timeout = "600s"
  running_timeout = "21600s"


  host {
    gce_instance {
#        service_account = "${google_service_account.developer_service_account.email}"
      machine_type                = "e2-standard-4"
     # boot_disk_size_gb           = 35
      disable_public_ip_addresses = true
      shielded_instance_config {
        enable_secure_boot = true
        enable_vtpm        = true
        enable_integrity_monitoring = true
              }
          }
            }

depends_on = [
    google_workstations_workstation_cluster.workstation_cluster,
  ]
}
*/