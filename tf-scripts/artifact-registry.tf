provider "google" { project = "kube-demo-488400" }

resource "google_project_service" "artifactregistry" {
  project = "kube-demo-488400"
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "my_repository" {
  location      = "asia-south1"
  repository_id = "test-registry"
  format        = "DOCKER"
  project       = "kube-demo-488400"
  depends_on    = [google_project_service.artifactregistry]
}
