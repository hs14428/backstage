provider "google" {
  project = "${{ values.projectId }}"
  region  = "${{ values.deploymentRegion }}"
  zone    = "${{ values.deploymentZone }}"
}

resource "google_compute_instance" "backstage_vm" {
  provider = google
  name = "${{ values.instanceName }}"
  machine_type = "${{ values.instanceMachineType }}"
  zone = "${{ values.deploymentZone }}"

  labels = {
    environment = "${{ values.deploymentEnvironment }}"
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
  name = "backstage-vm-bootdisk"
  type = "pd-ssd"
  zone = "${{ values.deploymentZone }}"
  image = "${{ values.instanceDiskOS }}"
  labels = {
    environment = "${{ values.deploymentEnvironment }}"
  }
  size = "${{ values.instanceDiskSize }}"
}
