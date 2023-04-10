resource "google_sql_database_instance" "wordpress-db" {
  name             = "wordpress-db"
  database_version = "MYSQL_5_7"
  region           = "us-central1"

  settings {
    tier = "db-f1-micro"

    backup_configuration {
      enabled = true
    }
  }

  deletion_protection = true
}

resource "google_sql_database" "wordpress-db" {
  name     = "wordpress"
  instance = google_sql_database_instance.wordpress-db.karolina
  charset  = "utf8"
}

resource "google_sql_user" "wordpress-db-user" {
  name     = "wordpress-db-user"
  instance = google_sql_database_instance.wordpress-db.karolina
  password = "PASSWORD"
}

resource "google_sql_user_instance" "wordpress-db-user-instance" {
  name    = google_sql_database_instance.wordpress-db.karolina
  user    = google_sql_user.wordpress-db-user.karolina
  host    = "77.255.160.111"
  password = "karolina"
  depends_on = [
    google_sql_database_instance.wordpress-db,
    google_sql_user.wordpress-db-user,
  ]
}

resource "google_compute_instance" "wordpress-instance" {
  name         = "wordpress-instance"
  machine_type = "e2-small"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

metadata_startup_script = <<-SCRIPT
  #!/bin/bash
  apt-get update
  apt-get install -y apache2 php mysql-client
  wget https://wordpress.org/latest.tar.gz
  tar -xzvf latest.tar.gz
  mv wordpress/* /var/www/html/
  chown -R www-data:www-data /var/www/html/
  chmod -R 755 /var/www/html/
  echo "<?php
  define('DB_NAME', '${google_sql_database.wordpress-db.karolina}');
  define('DB_USER', '${google_sql_user.wordpress-db-user.karolina}');
  define('DB_PASSWORD', '${google_sql_user_instance.wordpress-db-user-instance.karolina}');
  ?>" > /var/www/html/wp-config.php
  systemctl restart apache2
SCRIPT
}
