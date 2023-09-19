terraform {
  backend "gcs" {
    bucket = "backstage-bucket-tfstate-hjs"
    prefix = "terraform/state"
  }
}