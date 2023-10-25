#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "2 Arguments are required: <SERVICE_ACCOUNT> <PROJECT_HOME>"
  exit # Exit with 0 to not block shell initialization
fi

export SERVICE_ACCOUNT=$1
export PROJECT_HOME=$2

# used by maven to acccess Assured OSS repos
export GOOGLE_OAUTH_ACCESS_TOKEN="$(curl -s http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token -H 'Metadata-Flavor:Google' | sed -E 's/.*"access_token":"?([^,"]*)"?.*/\1/')"

export MVN_VERSION="3.8.7"
export M2_HOME="/opt/apache-maven/apache-maven-${MVN_VERSION}"
# required so mvnw installs in the right place
export MAVEN_USER_HOME="$M2_HOME"
# Use for debugging
export MVNW_VERBOSE=true
export PATH="${M2_HOME}/bin:${PATH}"

if [ ! -f "$M2_HOME.zip" ]; then
  sudo mkdir -p /opt/apache-maven
  sudo chown user:user /opt/apache-maven/

  echo "Downloading apache maven..."
  # See https://maven.apache.org/wrapper/ for docs
  curl -s -L -H "Authorization: Bearer $GOOGLE_OAUTH_ACCESS_TOKEN" \
    https://us-maven.pkg.dev/cloud-aoss/java/org/apache/maven/apache-maven/${MVN_VERSION}/apache-maven-${MVN_VERSION}-bin.zip \
    --output "$M2_HOME.zip"
fi

if [ ! -f "/var/log/minikube.log" ]; then
  sudo touch /var/log/minikube.log
  sudo chown user:user /var/log/minikube.log
fi

if [ ! -f "/var/log/skaffold.log" ]; then
  sudo touch /var/log/skaffold.log
  sudo chown user:user /var/log/skaffold.log
fi

startMinikube() {
  daemonize=$1
  if [ "$daemonize" = "-d" ]; then
    nohup minikube start >> /var/log/minikube.log 2>&1 &
  else
    minikube start 2>&1 | tee -a /var/log/minikube.log
  fi
}
export -f startMinikube

if [[ ! $(pgrep -f minikube) ]]; then
  echo "Starting minikube..."
  sudo touch /var/log/minikube.log
  sudo chown user:user /var/log/minikube.log
  startMinikube "-d"
  echo "logging to: /var/log/minikube.log"
fi

counter=0
while [ "$(minikube status --format "{{.Host}}" 2> /dev/null)" != "Running" ]
do
  if [ "${counter}" -eq "0" ]; then
    printf "waiting for minikube start (press CTL+c to exit)"
  fi
  printf '.'
  ((counter++))
  sleep 1
done

if [ "${counter}" -ne "0" ]; then
  printf "\nStarted minikube.."
fi

eval $(minikube docker-env)

startSkaffold() {
  daemonize=$1
  if [ "$daemonize" = "-d" ]; then
    (cd ${PROJECT_HOME} && nohup skaffold dev -f ${PROJECT_HOME}/skaffold.yaml -p dev --trigger notify >> /var/log/skaffold.log 2>&1 &)
  else
    (cd ${PROJECT_HOME} && skaffold dev -f ${PROJECT_HOME}/skaffold.yaml -p dev --trigger notify 2>&1 | tee -a /var/log/skaffold.log)
  fi
}
export -f startSkaffold

if [[ ! $(pgrep -f skaffold) ]]; then
  echo "Starting skaffold dev..."
  sudo touch /var/log/skaffold.log
  sudo chown user:user /var/log/skaffold.log
  startSkaffold "-d"
  echo "logging to: /var/log/skaffold.log"
fi
