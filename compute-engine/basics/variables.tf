variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "learning-12613"
}

variable "region" {
  description = "Region for resources"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "Zone for the instance"
  type        = string
  default     = "europe-west1-c"
}

variable "instance_name" {
  description = "Name of the compute instance"
  type        = string
  default     = "appache-instance-20251125-154058"
}

variable "instance_description" {
  description = "Description of the compute instance"
  type        = string
  default     = "Test VM"
}

variable "machine_type" {
  description = "Compute Engine machine type"
  type        = string
  default     = "e2-micro"
}

variable "boot_disk_size_gb" {
  description = "Boot disk size in GB"
  type        = number
  default     = 10
}

variable "boot_disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "pd-balanced"
}

variable "boot_disk_image" {
  description = "Boot disk image"
  type        = string
  default     = "projects/debian-cloud/global/images/debian-12-bookworm-v20251111"
}

variable "subnetwork_name" {
  description = "Name of the subnetwork in the given project/region"
  type        = string
  default     = "default"
}

variable "service_account_email" {
  description = "Service account email used by the instance"
  type        = string
  default     = "terraform-sevice-account@learning-12613.iam.gserviceaccount.com"
}

variable "service_account_scopes" {
  description = "OAuth2 scopes for the instance service account"
  type        = list(string)
  default = [
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/trace.append",
  ]
}

variable "instance_tags" {
  description = "Network tags for the instance"
  type        = list(string)
  default     = ["http-server", "https-server"]
}

variable "startup_script" {
  description = "Startup script to run on instance boot"
  type        = string
  default     = <<SCRIPT
    #! /bin/bash
    apt update
    apt -y install apache2
    cat <<EOF > /var/www/html/index.html
    <html><body><p>Linux startup script added directly.</p></body></html>
    EOF
  SCRIPT
}

# Ops Agent / Cloud Operations module variables

variable "ops_agent_assignment_id" {
  description = "Assignment ID for the Ops Agent policy"
  type        = string
  default     = "goog-ops-agent-v2-x86-template-1-4-0-europe-west1-c"
}

variable "ops_agent_package_state" {
  description = "Package state for Ops Agent (e.g., installed)"
  type        = string
  default     = "installed"
}

variable "ops_agent_version" {
  description = "Ops Agent version"
  type        = string
  default     = "latest"
}

variable "ops_agent_policy_label" {
  description = "Label value used to target instances for Ops Agent policy"
  type        = string
  default     = "v2-x86-template-1-4-0"
}
