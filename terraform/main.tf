provider "google" {
  project = "k8s-assignment-utsha"
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Create a GKE cluster
resource "google_container_cluster" "utsha_gke_cluster" {
  name               = "utsha-gke-cluster"
  location           = "us-central1-a"
  initial_node_count = 1

  
  node_config {
    # Use e2-micro as specified in requirements
    machine_type = "e2-medium"
    
    # Use COS with containerd as specified in requirements
    image_type   = "cos_containerd"
    
    # Use standard persistent disk with 10GB as per requirements
    disk_type    = "pd-standard"
    disk_size_gb = 10

    # Standard set of OAuth scopes for GKE nodes
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/compute",
    ]
  }
}

# Output the cluster name and location for reference
output "cluster_name" {
  value = google_container_cluster.utsha_gke_cluster.name
}

output "cluster_location" {
  value = google_container_cluster.utsha_gke_cluster.location
}