# GKE Node Pool

## Usage

```hcl
module "k8s" {
  source  = "git@github.com:dansible/terraform-google_gke_infra.git?ref=v0.5.1"
  name    = "${var.team_name}"
  region  = "${var.region}"
  project = "${var.project}"
}

module "node_pool" {
  source          = "git@github.com:dansible/terraform-google_gke_node_pool.git?ref=v0.0.1"
  name            = "${var.team_name}"
  region          = "${var.region}"
  project         = "${var.project}"
  cluster         = "${module.k8s.cluster_name}
  service_account = "${module.k8s.service_account}"
}
```

**NOTE:** All parameters are configurable. Please see [below](#variables) for information on each configuration option.

## Variables

For more info, please see the [variables file](variables.tf).

### Required Variables

| Variable                 | Description                        |
| :----------------------- | :----------------------------------|
| `name` | Name to use as a prefix to all the resources. |
| `region` | The region that hosts the cluster. Each node will be put in a different availability zone in the region for HA. |
| `cluster` | The cluster to create the node pool for. |
| `service_account` | The service account to be used by the Node VMs. Can be taken as output from gke_infra module. |

### Optional Variables

| Variable               | Description                         | Default                                               |
| :--------------------- | :---------------------------------- | :---------------------------------------------------- |
| `project` | The ID of the google project to which the resource belongs. | Value configured in `gcloud` client. |
| `k8s_version` | Default K8s versions for API and Node. | `1.11` |
| `initial_node_count` | The initial node count for the pool. | `3` |
| `max_pods_per_node` | The maximum number of pods per node in this node pool. | `110` |
| `autoscaling_nodes_min` | Minimum number of nodes to create in each zone. Must be >=1 and <= autoscaling_nodes_max. | `1` |
| `autoscaling_nodes_max` | Maximum number of nodes to create in each zone. Must be >= autoscaling_nodes_min. | `3` |
| `enable_auto_repair` | Whether the nodes will be automatically repaired. | `true` |
| `auto_upgrade` | Whether the nodes will be automatically upgraded. | `true` |
| `disk_size` | Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. | `20` |
| `disk_type` | Type of the disk attached to each node (e.g. 'pd-standard' or 'pd-ssd'). | `pd-standard` |
| `node_image` | The image type to use for this node. Note that changing the image type will delete and recreate all nodes in the node pool. | `COS` |
| `local_ssd_count` | The amount of local SSD disks that will be attached to each cluster node. | `0` |
| `machine_type` | The Google Compute Engine machine type to use for the nodes. | `n1-standard-1` |
| `preemptible_nodes` | Whether to enable Premptible nodes. | `true` |
| `node_metadata` | How to expose the node metadata to the workload running on the node. | `SECURE` |
| `oauth_scopes` | The set of Google API scopes to be made available on all of the node VMs under the default service account. | [`see vars file`](variables.tf) |
| `node_tags` | The list of instance tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls. | `[]` |


### Output Variables

| Variable                 | Description                        |
| :----------------------- | :----------------------------------|
| `node_pool_name` | The name of the node pool. |

## Links

- https://www.terraform.io/docs/providers/google/r/container_node_pool.html
- https://www.terraform.io/docs/providers/google/r/container_cluster.html
