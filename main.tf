# https://cloud.google.com/vpc/docs/shared-vpc


resource "random_id" "host_project" {
  byte_length = 8
}

resource "random_id" "service_project_1" {
  byte_length = 8
}

# ####Creating the Projects 


# # The project which owns the VPC.
resource "google_project" "host_project" {
  name            = "Host Project"
  project_id      = "tf-vpc-${random_id.host_project.hex}"
  billing_account = var.billing_account_id
  folder_id       = google_folder.Management-Coalfire.name
}

resource "google_folder" "Management-Coalfire" {
  display_name = "Management-Coalfire-Project"
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
  display_name = "Application-Coalfire-Project"
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

########################################################################################################
#####Create the Hosted shared Network 

########################################################################################################

resource "google_compute_network" "shared_network" {
  name                    = "shared-network"
  auto_create_subnetworks = "false"
  project                 = google_compute_shared_vpc_host_project.host_project.project

  depends_on = [
    google_compute_shared_vpc_service_project.service_project_1
  ]
}



# Allow the hosted network to be hit over ICMP, SSH, and HTTP.
resource "google_compute_firewall" "shared_network-fw" {
  name    = "allow-ssh-icmp-from-iap-shared"
  network = google_compute_network.shared_network.self_link
    project = google_compute_shared_vpc_host_project.host_project.project

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}


####Create Firewall record for the custom subnet for Egress

resource "google_compute_firewall" "internet_firewall" {
  name    = "allow-ssh-80-from-iap"
   network = google_compute_network.shared_network.self_link
    project = google_compute_shared_vpc_host_project.host_project.project
   

 allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
    source_ranges = ["35.235.240.0"]
}


####Create Firewall record for the custom subnet for no Internet

resource "google_compute_firewall" "firewall-nointernet" {
    name          = "vpc-${var.network}-firewall-${var.rule-name}"
    network = google_compute_network.shared_network.self_link
     project = google_compute_shared_vpc_host_project.host_project.project

  allow {
    protocol = var.protocol
    ports    = var.protocol == "tcp" || var.protocol == "udp" ? var.ports : ["22"]
  }

  target_tags   = var.tags
  source_ranges = var.source_ranges

}

#####Subnet Builds


resource "google_compute_subnetwork" "coalfire_shared_network_sub1" {
  name          = "coalfire-custom-network-sub1"
  ip_cidr_range = "10.0.0.0/24"
  network      = google_compute_network.shared_network.self_link
   project = google_compute_network.shared_network.project
  region        = var.region
}

resource "google_compute_subnetwork" "coalfire_shared_network_sub2" {
  name          = "coalfire-custom-network-sub2"
  ip_cidr_range = "10.0.1.0/24"
     network = google_compute_network.shared_network.self_link
     project = google_compute_network.shared_network.project
  region        = var.region
}



resource "google_compute_subnetwork" "coalfire_shared_network_sub3" {
  name          = "coalfire-custom-network-sub3"
  ip_cidr_range = "10.0.2.0/24"
     network = google_compute_network.shared_network.self_link
     project = google_compute_network.shared_network.project
  region        = var.region
}


resource "google_compute_subnetwork" "coalfire_shared_network_sub4" {
  name          = "coalfire-custom-network-sub3"
  ip_cidr_range = "10.0.3.0/24"
     network = google_compute_network.shared_network.self_link
     project = google_compute_network.shared_network.project
  region        = var.region
}


##############################################################################
#############################################################################
# # Create a VM which hosts a web page stating its identity ("VM1")
 resource "google_compute_instance" "compute-rhel-internet" {
   name         = "compute-rhel-internet"

    project = google_compute_network.shared_network.project
   machine_type = "f1-micro"
   zone         = var.region_zone
   allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/rhel-cloud/global/images/rhel-8-v20201014"
    }
  }

  metadata_startup_script = "VM_NAME=VM1\n${file("scripts/install-vm.sh")}"



    network_interface {
     subnetwork_project = google_compute_network.shared_network.project
     subnetwork = google_compute_subnetwork.coalfire_shared_network_sub1.self_link

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }

  depends_on = [google_project_service.host_project]
}







#############################################################################
# # Create a VM which hosts a web page stating its identity ("VM1")
 resource "google_compute_instance" "apache-vm" {
   name         = "apache-vm"
    project = google_compute_network.shared_network.project
   machine_type = "f1-micro"
   zone         = var.region_zone_c
   allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "projects/rhel-cloud/global/images/rhel-8-v20201014"
    }
  }

  metadata_startup_script = "VM_NAME=VM1\n${file("scripts/install-vm.sh")}"



    network_interface {
     subnetwork_project = google_compute_network.shared_network.project
     subnetwork = google_compute_subnetwork.coalfire_shared_network_sub3.self_link

  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }

  depends_on = [google_project_service.host_project]
}


#################Creation of LB forwarding rules
######################################################################################################

resource "google_compute_global_forwarding_rule" "default" {
  name       = "global-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name        = "target-proxy"
  description = "a description"
  url_map     = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name            = "url-map-target-proxy"
  description     = "a description"
  default_service = google_compute_backend_service.default.id

  host_rule {
    hosts        = ["apache-vm"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.default.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.default.id
    }
  }
}

resource "google_compute_backend_service" "default" {
  name        = "backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = [google_compute_http_health_check.default.id]
}

resource "google_compute_http_health_check" "default" {
  name               = "check-backend"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}

###############Create NAT IPS
######################################################################################################


resource "google_compute_address" "project-nat-ips" {
  count   = length(var.nat_ips)
  name    = "nat-ips"
  project = google_compute_network.shared_network.project
  region  = var.region
}



########Create NAT GW
######################################################################################################

module "cloud-nat" {
  source     = "./modules/terraform-google-cloud-nat"
  router  = "coalfire-router-2"
  project_id = google_compute_network.shared_network.project
  region     = var.region
}



#####Cloud Router
######################################################################################################


module "cloud_router" {
  source  = "./modules/terraform-google-cloud-router"
 

  name    = "coalfire-router-2"
   project = google_compute_network.shared_network.project
   region  = var.region
   network = google_compute_network.shared_network.self_link
}

