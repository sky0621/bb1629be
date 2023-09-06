#!/bin/bash -e

# shellcheck disable=SC2039
services=(
    networkmanagement.googleapis.com \
    compute.googleapis.com \
    iamcredentials.googleapis.com \
    cloudbuild.googleapis.com \
    clouddeploy.googleapis.com \
    run.googleapis.com \
    artifactregistry.googleapis.com \
    cloudresourcemanager.googleapis.com \
)

# shellcheck disable=SC2039
for service in "${services[@]}"
do
  gcloud services enable "${service}"
done
