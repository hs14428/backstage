terraform {
  backend "gcs" {
    bucket = "backstage-bucket-services-tfstate"
    prefix = "terraform/state/gce/backstage-demo-1"
  }
}
