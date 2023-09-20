provider "google" {
  project = "backstage-test-398910"
  region  = "europe-west3"
  zone    = "europe-west3-c"
}

resource "google_compute_instance" "backstage_vm" {
  provider = google
  name = "backstage-test1"
  machine_type = "n1-standard-1"
  zone = "europe-west3-c"

  labels = {
    environment = "dev"
  }

  boot_disk {
    source = "${google_compute_disk.backstage_vm_compute_disk.name}"
  }

  network_interface {
    network = "backstage-vpc"
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
  name = "backstage-vm-bootdisk"
  type = "pd-ssd"
  zone = "europe-west3-c"
  image = "debian-cloud/debian-11"
  labels = {
    environment = "dev"
  }
  size = "10"
}