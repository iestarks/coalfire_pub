## Coalfire Interview 

# Irving Starks - ncsu.ee2000@gmail.com

# Scenario A 

Coalfire is looking to create a proof of concept environment in GCP. 

They want a VPC as outlined below. 

The company will have a management folder and host project that will contain the VPC and subnets. 

And an application folder  and service project  that will deploy resources into the shared subnets. 

Subnets should be deployed with future high availability in mind. 

 The company would also like to use Terraform to manage their infrastructure via code.

• 1 VPC
• 4 subnets

o Sub1 – 10.0.0.0/24 (should be accessible from internet).  
o Sub2 – 10.0.1.0/24 (should be accessible from internet).  
o Sub3 – 10.0.2.0/24 (should NOT be accessible from internet)
o Sub4 – 10.0.3.0/24 (should NOT be accessible from internet)

• 1 compute instance running RedHat in subnet sub1  
o 20 GB storage
o Choose the best instance type for the job and explain reasoning

• 1 compute instance running RedHat in subnet sub3  
o 20 GB storage
o Choose the best instance type for the job and explain reasoning

o Script the installation of apache on this instance.  
• 1 Layer 7 Load Balancer that listens on port 80 and forwards traffic to the instance in Sub3

Instructions

1. Create Terraform code that creates these networking and compute constructs and push the code
to a public GitHub repository. 

Any detail that is not provided in the scenario is up to your discretion.
 
 Use of Terraform modules is encouraged.

2. Login to the instance in sub1 and take a screenshot of the terminal logged in. Include this
screenshot in your documentation.


3. Document how you implemented the technical challenge, including any sources you used. You
may be asked to walkthrough your solution as if presenting to a client. 

Your final deliverables will include the URL for your GitHub repository and your documentation. 

The structure and formatting of the documentation is up to you.

##################################################################################################################################

Some areas where I performed some research into developing the Terraform IAC for this project

 # NAT Module source
* https://github.com/terraform-google-modules/terraform-google-cloud-nat

 # Cloud Router Module source
 
* https://github.com/terraform-google-modules/terraform-google-cloud-router

####################################################################################################################################
* google_compute_global_forwarding_rule

  https://www.terraform.io/docs/providers/google/r/compute_global_forwarding_rule.html

* Building internet connectivity for private VMs

* https://cloud.google.com/solutions/building-internet-connectivity-for-private-vms

* NAT

* https://www.terraform.io/docs/providers/google/r/compute_router_nat.html
 

* Shared VPC Host Project

* https://www.terraform.io/docs/providers/google/r/compute_shared_vpc_host_project.html


### Org Folder and Project View

![Org Folder and Project View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_25.png)


#### Apache Terminal RHEL
![Apache Terminal](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_22.png)


#### Internet Facing RHEL
![Apache Terminal](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_23.png)


##### Screenshots

* [GCP IAM Member View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_10.png)
* [GCP Host Project Service Account View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_11.png)
* [GCP Organization Folder View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_12.png)
* [Apache Shell RHEL View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_14.png)
* [GCP Apache VM Instance Details View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_18.png)
* [GCP Compute RHEL Instance View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_17.png)
* [GCP VM Instances IP View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_19.png)
* [GCP NAT View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_6.png)
* [GCP VPC Network View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_8.png)
* [GCP External IP View](https://github.com/iestarks/coalfire/blob/main/screenshots/Snip20201018_9.png)

#setup-sa script created the Service Account used as well as added the appropriate roles to run terraform, for Org admin rights.

* irvs@Irvs-MacBook-Pro scripts % ./setup-sa.sh
* Verifying organization...
* Verifying project...
* Verifying billing account...
* Verifying project folder...
* Creating Seed Service Account named triplex-sa@iac-triplex.iam.gserviceaccount.com...
* Created service account [triplex-sa].
* Downloading key to credentials.json...
* Applying permissions for folder 702060037836...
* Adding role roles/resourcemanager.folderViewer...
* Applying permissions for org 227459452227 and project iac-triplex...
* Adding role roles/resourcemanager.organizationViewer...
* Adding role roles/resourcemanager.projectCreator...
* Adding role roles/billing.user...
* Adding role roles/compute.xpnAdmin...
* Adding role roles/compute.networkAdmin...
* Adding role roles/iam.serviceAccountAdmin...
* Adding role roles/resourcemanager.projectIamAdmin...
* Enabling APIs...
* Enabling the billing account...
* Updated IAM policy for account [016F65-7A2064-F1458E].
* bindings:
* - members:
*  - user:triple@triplexinvestments.com
*  role: roles/billing.admin
* - members:
*   - deleted:serviceAccount:triplex-sa@iac-triplex.iam.gserviceaccount.com?uid=113600138995246214756
*   - serviceAccount:triplex-sa@iac-triplex.iam.gserviceaccount.com
*   role: roles/billing.user
* etag: BwWyCTpZd4c=
* version: 1


## Terraform State list

irvs@Irvs-MacBook-Pro coalfire_vpc % terraform state list

* google_compute_backend_service.default
* google_compute_firewall.firewall-nointernet
* google_compute_firewall.internet_firewall
* google_compute_firewall.shared_network-fw
* google_compute_global_forwarding_rule.default
* google_compute_http_health_check.default
* google_compute_instance.apache-vm
* google_compute_instance.compute-rhel-internet
* google_compute_network.shared_network
* google_compute_shared_vpc_host_project.host_project
* google_compute_shared_vpc_service_project.service_project_1
* google_compute_subnetwork.coalfire_shared_network_sub1
* google_compute_subnetwork.coalfire_shared_network_sub3
* google_compute_target_http_proxy.default
* google_compute_url_map.default
* google_folder.Application-Coalfire
* google_folder.Management-Coalfire
* google_project.host_project
* google_project.service_project_1
* google_project_service.host_project
* google_project_service.service_project_1
* random_id.host_project
* random_id.service_project_1
* module.cloud-nat.google_compute_router_nat.main
* module.cloud-nat.random_string.name_suffix
* module.cloud_router.google_compute_router.router

### Extra work performed
* Terraform coded the Project and Host folder creation during Project build stage, as it was probably intended to be done manually or Out of State.
* Separated Instances in separate zones for HA

### Issues encountered
* Impersonating SA during project and folder creation, at ORG level. -- Resolve, discovered missing roles and ie ResourceManager.project.create and billing Admin.

* During inital GCP org account creation, New Orgs only allow 12 project folder creation,where you have to fill out a form to request additional Quotas. Problem there is Google has a horrible support model for these types of request, where online form does supply a ticket number after the quota request. Then you have to call and provide information, only to be told that there is no case referencing the form. You have to get the rep to create one but he or she will not assign or contact the team about the case. You basically have to wait until they get to it,which was stated to be 2 days or more. Therefore, if you are in an urgent or time sensitive deployement which requires the quotas of any magnitude, you are basically out of luck unless you recreate a new ORG, which is what I did to continue.

### Improvement Areas

 * Test Instance connectivity with no EXT IP to internet with only private IP, within A different REGION
 * Improve code to reference more modules during Infra build to reduce main code length.
 * Add Instance Template and Instance Group modules to compute layer for HA 
 
