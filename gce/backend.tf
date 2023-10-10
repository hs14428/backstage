terraform {
  backend "gcs" {
    bucket = "backstage-bucket-services-tfstate"
    prefix = "terraform/state/gce/google-next1"
  }
}
