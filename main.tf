# Versioning
terraform {
  required_version = ">= 0.11.9"
  backend "gcs" {}

  required_providers {
    google      = ">= 1.19.0"
    google-beta = ">= 1.19.0"
  }
}

# Google Provider info
##########################################################
provider "google" {
  version = "~> 1.19"
  region  = "${var.region}"
}

provider "google-beta" {
  version = "~> 1.19"
  region  = "${var.region}"
}

data "google_client_config" "gcloud" {}

# Node Pool
##########################################################
resource "google_container_node_pool" "node_pool" {
  provider           = "google-beta"
  name               = "${var.name}"
  cluster            = "${var.cluster}"
  project            = "${var.project}"
  region             = "${var.region}"
  initial_node_count = "${var.initial_node_count}"
  max_pods_per_node  = "${var.max_pods_per_node}"
  version            = "${var.k8s_version}"

  autoscaling {
    min_node_count = "${var.autoscaling_nodes_min}"
    max_node_count = "${var.autoscaling_nodes_max}"
  }

  management {
    auto_repair  = "${var.enable_auto_repair}"
    auto_upgrade = "${var.enable_auto_upgrade}"
  }

  node_config {
    disk_size_gb = "${var.disk_size}"
    disk_type    = "${var.disk_type}"

    # Forces new resource due to computing count :/
    # guest_accelerator {
    #   count = "${length(var.node_options["guest_accelerator"])}"
    #   type = "${var.node_options["guest_accelerator"]}"
    # }
    image_type = "${var.node_image}"

    # labels = "${var.node_labels}" # Forces new resource due to computing count :/
    local_ssd_count = "${var.local_ssd_count}"
    machine_type    = "${var.machine_type}"

    # metadata =  "${var.extras["node_metadata"]}" # Forces new resource due to computing count :/
    # minimum_cpu_platform = "" # TODO
    oauth_scopes    = "${var.oauth_scopes}"
    preemptible     = "${var.preemptible_nodes}"
    service_account = "${var.service_account}"
    tags            = "${var.node_tags}"

    # taint {
    #   key = ""
    #   value = ""
    #   effect = ""
    # }
    workload_metadata_config = {
      node_metadata = "${var.node_metadata}"
    }
  }
}
