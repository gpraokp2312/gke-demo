# Create a custom VPC network and subnet
resource "google_compute_network" "vpc" {
  name                    = "gke-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "10.0.0.0/26"
  region        = "asia-south1"
  network       = google_compute_network.vpc.name
}

# Create the GKE cluster, deleting the default node pool immediately
resource "google_container_cluster" "primary" {
  name               = "my-gke-cluster"
  location           = "asia-south1"
  network            = google_compute_network.vpc.name
  subnetwork         = google_compute_subnetwork.subnet.name
  remove_default_node_pool = true
  initial_node_count = 1
}

# Create a separate, managed node pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "my-node-pool"
  location   = "asia-south1-a"
  cluster    = google_container_cluster.primary.name
  node_count = 3
  node_config {
    machine_type = "e2-micro"
    oauth_scopes = ["https://www.googleapis.com"]
  }
}
