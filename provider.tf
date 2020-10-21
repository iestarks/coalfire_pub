provider "google" {
  #credentials = file("./credentials.json")
  project     = "iac-triplex"
  region      = "us-east1"
}
provider "random" {
}
