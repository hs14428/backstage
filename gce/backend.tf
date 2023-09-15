terraform {
  backend "gcs" {
    bucket = "backstage-bucket-tfstate"
    prefix = "terraform/state"
  }
}