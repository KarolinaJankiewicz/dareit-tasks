resource "google_compute_firewall" "wordpress_ingress" {
  name    = "wordpress"
  network = "default"
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "wordpress_ingress_ssh" {
  name    = "example-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["77.255.160.111/32"]
}

resource "google_sql_database_instance" "karolina" {
  database_version = "mysql_5_7"
  name             = "example"
  region           = "us-central1"
  
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "karolina" {
  name     = "example"
  instance = google_sql_database_instance.karolina.name
}

resource "google_sql_user" "my_user" {
  name     = "user"
  password = "karolina"
  instance = google_sql_database_instance.karolina.name
}

resource "google_compute_instance" "wordpress_instance" {
  name         = "wordpress-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-c"

  tags = ["dareit"]

  boot_disk {
    initialize_params {
      image                  = "debian-cloud/debian-11"
      labels                 = {
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