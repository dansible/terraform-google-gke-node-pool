# Required
##########################################################
variable "name" {
  description = "Name to use as a prefix to all the resources."
}

variable "region" {
  description = "The region to create the cluster in (automatically distributes masters and nodes across zones). See: https://cloud.google.com/kubernetes-engine/docs/concepts/regional-clusters"
}

variable "cluster" {
  description = "The cluster to create the node pool for."
}

variable "service_account" {
  description = "The service account to be used by the Node VMs. Can be taken as output from gke_infra module."
}

# Optional
##########################################################
variable "project" {
  description = "The ID of the google project to which the resource belongs."
  default     = ""
}

variable "k8s_version" {
  description = "Default K8s versions for API and Node. See: https://www.terraform.io/docs/providers/google/r/container_cluster.html#min_master_version"
  default     = "1.11"
}

variable "initial_node_count" {
  description = "The initial node count for the pool. Changing this will force recreation of the resource."
  default     = 3
}

variable "max_pods_per_node" {
  description = "The maximum number of pods per node in this node pool."
  default = 110
}

variable "autoscaling_nodes_min" {
  description = "Minimum number of nodes to create in each zone. Must be >=1 and <= autoscaling_nodes_max."
  default = 1
}

variable "autoscaling_nodes_max" {
  description = "Maximum number of nodes to create in each zone. Must be >= autoscaling_nodes_min."
  default = 3
}

variable "enable_auto_repair" {
  description = "Whether the nodes will be automatically repaired."
  default = true
}

variable "auto_upgrade" {
  description = "Whether the nodes will be automatically upgraded."
  default = true
}

variable "disk_size" {
  description = "Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB."
  default = 20
}

variable "disk_type" {
  description = "Type of the disk attached to each node (e.g. 'pd-standard' or 'pd-ssd')."
  default = "pd-standard"
}

variable "node_image" {
  description = "The image type to use for this node. Note that changing the image type will delete and recreate all nodes in the node pool. COS/UBUNTU"
  default = "COS"
}

variable "local_ssd_count" {
  description = "The amount of local SSD disks that will be attached to each cluster node."
  default = 0
}

variable "machine_type" {
  description = "The Google Compute Engine machine type to use for the nodes."
  default = "n1-standard-1"
}

variable "preemptible_nodes" {
  description = "Whether to enable Premptible nodes: cheaper instances that last a maximum of 24 hours and provide no availability guarantees. https://cloud.google.com/kubernetes-engine/docs/how-to/preemptible-vms"
  default = true
}

variable "node_metadata" {
  description = "How to expose the node metadata to the workload running on the node. See: https://www.terraform.io/docs/providers/google/r/container_cluster.html#node_metadata"
  default = "SECURE"
}

variable "oauth_scopes" {
  type        = "list"
  description = "The set of Google API scopes to be made available on all of the node VMs under the default service account. See: https://www.terraform.io/docs/providers/google/r/container_cluster.html#oauth_scopes"
  default = [
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/compute",
  ]
}

variable "node_tags" {
  type        = "list"
  default     = []
  description = "The list of instance tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls."
}
