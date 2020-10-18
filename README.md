# coalfire
Interview GCP Test Case

## Irving Starks
### ncsu.ee2000@gmail.com


## Coalfire Technical Challenge

## Due: Sunday, 10/18/20 @ 5:00 PM EDT

Before you begin, please note:

1. You must perform this challenge by yourself, no other persons may assist you.

2. Try to accomplish as many tasks as you can within the time-period allotted. Quality of the
implementation is an important factor.

3. You are strongly encouraged to search the web and use resources like Stack Overflow and
GitHub. 

Please note in the write-up the URLs/sources you used for the final deliverable. The
amount of resources you use does not count negatively; we are interested in both the end result
and the process you used to get there.

4. If you are unsure on how to complete a task, or your implementation is not working,
documenting the process you went through and what issues your ran into is also strongly
encouraged as it highlights your thought process when posed with a challenge.

5. Do not post or share this Technical Challenge or information about it to the Internet. Each
technical challenge has distinct differences and can be tied back to the individual who received
it.

Scenario
A company is looking to create a proof of concept environment in GCP. 

They want a VPC as outlined below. 

The company will have a management folder and host project that will contain the VPC and
subnets and an application folder and service project that will deploy resources into the shared subnets.

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

Instructions

1. Create Terraform code that creates these networking and compute constructs and push the code
to a public GitHub repository. 

Any detail that is not provided in the scenario is up to your
discretion.
 Use of Terraform modules is encouraged.

2. Login to the instance in sub1 and take a screenshot of the terminal logged in. Include this
screenshot in your documentation.


3. Document how you implemented the technical challenge, including any sources you used. You
may be asked to walkthrough your solution as if presenting to a client. 

Your final deliverables will include the URL for your GitHub repository and your documentation. The structure and formatting of the documentation is up to you.
Upon completing the challenge, please email your documentation and the link to your public GitHub
repository to
# campbell.ware@coalfire.com for review. If you have further clarification questions, or issues, please notify us immediately.

Some areas where I performed some research into developing the Terraform IAC for this project

# google_compute_global_forwarding_rule

https://www.terraform.io/docs/providers/google/r/compute_global_forwarding_rule.html

# Building internet connectivity for private VMs

https://cloud.google.com/solutions/building-internet-connectivity-for-private-vms

# NAT

https://www.terraform.io/docs/providers/google/r/compute_router_nat.html


# Shared VPC Host Project

https://www.terraform.io/docs/providers/google/r/compute_shared_vpc_host_project.html


# Apache install on NAT GW RHEL host

[triple@apache-vm ~]$ sudo service httpd start
Redirecting to /bin/systemctl start httpd.service
[triple@apache-vm ~]$ sudo chkconfig httpd on
Note: Forwarding request to 'systemctl enable httpd.service'.
[triple@apache-vm ~]$ httpd -v
Server version: Apache/2.4.37 (Red Hat Enterprise Linux)
Server built:   Dec  2 2019 14:15:24
[triple@apache-vm ~]$ 


