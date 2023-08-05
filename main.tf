terraform {
  required_version = ">=1.0"
  backend "local" {}
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "prefect-395009"
  region  = "australia-southeast1"
}

## CREATING A GOOGLE COMPUTE INSTANCE

resource "google_compute_instance" "prefect" {
  boot_disk {
    auto_delete = true
    device_name = "prefect"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230711"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-medium"
  name         = "prefect"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/prefect-395009/regions/australia-southeast1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = "australia-southeast1-a"
}

# CREATE AN S3 BUCKET

resource "google_storage_bucket" "orchestration" {
  name                        = "prefect-deployments-dev"
  location                    = "australia-southeast1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  force_destroy = true
}
