provider "google" {
  project = "${{ values.projectId }}"
  region  = "${{ values.deploymentRegion }}"
  zone    = "${{ values.deploymentZone }}"
}

resource "google_storage_bucket" "gcs_bucket" {
  name = "${{ values.bucketName }}"
  location = "${{ values.deploymentLocation }}"
}