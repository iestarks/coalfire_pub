variable "region" {
  default = "us-east1"
}


 variable "region_zone" {
   default = "us-east1-b"
 }

  variable "region_zone_c" {
   default = "us-east1-c"
 }

variable "nat_ips" {
  description = "List of self_links of external IPs. Changing this forces a new NAT to be created."
  type        = list(string)
  default     = []
}

variable "random_project_id" {
  description = "Adds a suffix of 4 random characters to the `project_id`"
  type        = bool
  default     = true
}

variable "project_name" {
  description = "The ID of the Google Cloud host project"
  default   = "Host Project Coalfire" 
  } 

variable "service_project_1" {
  description = "The ID of the Google Cloud standalone  project"
  default   = "Application Coalfire Project"
}

variable "org_id" {
  description = "The ID of the Google Cloud Organization."
  default = "227459452227"
}

variable "billing_account_id" {
  description = "The ID of the associated billing account (optional)."
  default = "016F65-7A2064-F1458E"
}

variable "credentials_file_path" {
  description = "Location of the credentials to use."
  default     = "~/.gcloud/Terraform.json"
}



##############Firewall Variables


variable "rule-name" {
  type          = string
  description   = "Name of the Firewall rule"
  default  = "coalfire-fw"
}
variable "network" {
  type          = string
  default       = "default"
  description   = "The name or self_link of the network to attach this firewall to"
}
variable "protocol" {
  type          = string
  default       = "tcp"
  description   = "The name of the protocol to allow"
}
variable "ports" {
  type      = list(number)
  default   = []
}
variable "tags" {
  type        = list(string)
  default     = []
  description = "A list of target tags for this firewall"
}
variable "source_ranges" {
  type        = list(string)
  default     = ["35.235.240.0"]
  description = "A list of source CIDR range to apply this rule."
}