# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.

resource "google_compute_instance" "vm" {
  count = 1
  name         = "${var.instance_name}-${count.index + 1}"
  description  = var.instance_description
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type

  boot_disk {
    auto_delete = true
    device_name = var.instance_name

    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size_gb
      type  = var.boot_disk_type
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = true

  labels = merge(
    {
      goog-ec-src = "vm_add-tf"
    },
    {
      goog-ops-agent-policy = var.ops_agent_policy_label
    }
  )

  metadata = {
    enable-osconfig = "TRUE"
    startup-script  = var.startup_script
  }

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/${var.project_id}/regions/${var.region}/subnetworks/${var.subnetwork_name}"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  shielded_instance_config {
    enable_integrity_monitoring = false
    enable_secure_boot          = true
    enable_vtpm                 = true
  }

  tags = var.instance_tags
}

module "ops_agent_policy" {
  source        = "github.com/terraform-google-modules/terraform-google-cloud-operations/modules/ops-agent-policy"
  project       = var.project_id
  zone          = var.zone
  assignment_id = var.ops_agent_assignment_id

  agents_rule = {
    package_state = var.ops_agent_package_state
    version       = var.ops_agent_version
  }

  instance_filter = {
    all = false
    inclusion_labels = [{
      labels = {
        goog-ops-agent-policy = var.ops_agent_policy_label
      }
    }]
  }
}
