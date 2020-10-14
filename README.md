# coalfire
Interview GCP Test Case


### Scenario

A company is looking to create a proof of concept environment in GCP. They want a VPC as outlined
below. 

The company will have a management folder and host project that will contain the VPC and
subnets 

and an application folder and service project that will deploy resources into the shared subnets.

Subnets should be deployed with future high availability in mind.

The company would also like to use

Terraform to manage their infrastructure via code.
• 1 VPC
• 4 subnets
o Sub1 – 10.0.0.0/24 (should be accessible from internet)
o Sub2 – 10.0.1.0/24 (should be accessible from internet)
o Sub3 – 10.0.2.0/24 (should NOT be accessible from internet)
o Sub4 – 10.0.3.0/24 (should NOT be accessible from internet)


• 1 compute instance running RedHat in subnet sub1
o 20 GB storage

o Choose the best instance type for the job and explain reasoning
• 1 compute instance running RedHat in subnet sub3
o 20 GB storage


o Choose the best instance type for the job and explain reasoning
o Script the installation of apache on this instance

• 1 Layer 7 Load Balancer that listens on port 80 and forwards traffic to the instance in Sub3