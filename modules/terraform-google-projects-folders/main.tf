# ####Creating the Projects 


# # The project which owns the VPC.
resource "google_project" "host_project" {
  name            = "Host Project"
  project_id      = "tf-vpc-${random_id.host_project.hex}"
  billing_account = var.billing_account_id
  folder_id       = google_folder.Management-Coalfire.name
}

resource "google_folder" "Management-Coalfire" {
  display_name = "Management-Coalfire"
  parent       = "organizations/227459452227"
}

# # One project which will use the VPC.
resource "google_project" "service_project_1" {
  name            = "Application-Coalfire"
  project_id      = "tf-vpc-${random_id.service_project_1.hex}"
  billing_account = var.billing_account_id
   folder_id       = google_folder.Application-Coalfire.name

}

#####  Create Application Folder in Org

resource "google_folder" "Application-Coalfire" {
  display_name = "Application-Coalfire"
  parent       = "organizations/227459452227"

}

   # Compute service needs to be enabled for all four new projects.
resource "google_project_service" "host_project" {
  project = google_project.host_project.project_id
  service = "compute.googleapis.com"
}

#####  Enable Compute API in Service Project 

resource "google_project_service" "service_project_1" {
  project = google_project.service_project_1.project_id
  service = "compute.googleapis.com"
}

# # Enable shared VPC hosting in the host project 

resource "google_compute_shared_vpc_host_project" "host_project" {
  project    = google_project.host_project.project_id
  depends_on = [google_project_service.host_project]
}

# # Enable shared VPC in the service project - explicitly depend on the host
# # project enabling it, because enabling shared VPC will fail if the host project
# # is not yet hosting.
resource "google_compute_shared_vpc_service_project" "service_project_1" {
  host_project    = google_project.host_project.project_id
  service_project = google_project.service_project_1.project_id

  depends_on = [
    google_compute_shared_vpc_host_project.host_project,
    google_project_service.service_project_1
  ]
}

