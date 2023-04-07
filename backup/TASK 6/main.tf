provider "google" {
  project = "infra-fortress-378414"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_storage_bucket" "bucket" {
  name = "ml2-karolina-bucket-name"
  storage_class = "standard"
  location = "us-central1"
}

data "google_iam_policy" "viewer" {
  binding {
    role = "roles/storage.objectViewer"
    members = [
        "allUsers",
    ] 
  }
}

resource "google_storage_bucket_iam_policy" "editor" {
  bucket = "ml-karolina-bucket-name"
  policy_data = "${data.google_iam_policy.viewer.policy_data}"
}



resource "google_compute_instance" "dare-id-vm" {
  name         = "karolina"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  tags = ["karolina"]

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


resource "google_sql_database_instance" "my_instance" {
  name = "karolina"
  database_version = "POSTGRES_13"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled = true
      private_network = "projects/your-project-id/global/networks/default"
    }

    database_flags {
      name = "max_connections"
      value = "100"
    }
  }
}

resource "google_sql_database" "my_database" {
  name = "dareit"
  instance = google_sql_database_instance.my_instance.name
}

resource "google_sql_user" "my_user" {
  name = "dareit_user"
  password = "karolina"
  instance = google_sql_database_instance.my_instance.name
}