resource "google_compute_instance" "dareit-vm-ci-1" {
  name         = "dareit-vm-tf-ci-1"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["dareit"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}

resource "google_storage_bucket" "kosiaszka-dareit" {
  name          = "kosiaszka-dareit"
  location      = "us-central1"
  storage_class = "STANDARD"
}

