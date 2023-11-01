provider "google" {
  project = "backstage-demo-393313"
  region  = "europe-west2"
  zone    = "europe-west2-c"
}

resource "google_compute_instance" "backstage_vm" {
  provider = google
  name = "github-log-check"
  machine_type = "e2-micro"
  zone = "europe-west2-c"

  labels = {
    environment = "development"
  }

  boot_disk {
    source = "${google_compute_disk.backstage_vm_compute_disk.name}"
  }

  network_interface {
    subnetwork = "backstage-main-subnetwork"
  }
  # Some changes require full VM restarts
  # consider disabling this flag in production
  #   depending on your needs
  allow_stopping_for_update = true
  shielded_instance_config {
    enable_secure_boot = true
  }
}

resource "google_compute_disk" "backstage_vm_compute_disk" {
  provider = google
  name = "github-log-check-bootdisk"
  type = "pd-ssd"
  zone = "europe-west2-c"
  image = "debian-cloud/debian-11"
  labels = {
    environment = "development"
  }
  size = "10"
}
