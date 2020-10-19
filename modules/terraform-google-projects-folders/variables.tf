
##### Variables file for the project and folders creations

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
