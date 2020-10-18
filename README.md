# coalfire
Interview GCP Test Case
# Coalfire Interview GCP Test Case

# Irving Starks
# ncsu.ee2000@gmail.com

3. Document how you implemented the technical challenge, including any sources you used. You
may be asked to walkthrough your solution as if presenting to a client. 

Your final deliverables will include the URL for your GitHub repository and your documentation. The structure and formatting of the documentation is up to you.
Your final deliverables will include the URL for your GitHub repository and your documentation. 

The structure and formatting of the documentation is up to you.

Upon completing the challenge, please email your documentation and the link to your public GitHub
repository to

# campbell.ware@coalfire.com for review. If you have further clarification questions, or issues, please notify us immediately.
##################################################################################################################################


Some areas where I performed some research into developing the Terraform IAC for this project
# Some areas where I performed some research into developing the Terraform IAC for this project

# google_compute_global_forwarding_rule

@@ -108,6 +114,23 @@ https://www.terraform.io/docs/providers/google/r/compute_shared_vpc_host_project

# Apache install on NAT GW RHEL host


[triple@apache-vm ~]$ /sbin/ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc fq_codel state UP group default qlen 1000
    link/ether 42:01:0a:00:02:06 brd ff:ff:ff:ff:ff:ff
 #   inet 10.0.2.6/32 scope global dynamic noprefixroute eth0
       valid_lft 3414sec preferred_lft 3414sec
    inet6 fe80::da4c:58ee:efe9:beb/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

### Apache installed

[triple@apache-vm ~]$ sudo service httpd start
Redirecting to /bin/systemctl start httpd.service
[triple@apache-vm ~]$ sudo chkconfig httpd on
@@ -118,3 +141,31 @@ Server built:   Dec  2 2019 14:15:24
[triple@apache-vm ~]$ 



#### Internet Facing RHEL

[triple@compute-rhel-internet ~]$ /sbin/ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc fq_codel state UP group default qlen 1000
    link/ether 42:01:0a:00:00:05 brd ff:ff:ff:ff:ff:ff
#     inet 10.0.0.5/32 scope global dynamic noprefixroute eth0
       valid_lft 2510sec preferred_lft 2510sec
    inet6 fe80::3f3b:65ab:59ee:2a14/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

### Apache installed

[triple@compute-rhel-internet ~]$ sudo service httpd start
Redirecting to /bin/systemctl start httpd.service

[triple@compute-rhel-internet ~]$ sudo chkconfig httpd on
Note: Forwarding request to 'systemctl enable httpd.service'.

[triple@compute-rhel-internet ~]$ httpd -v
Server version: Apache/2.4.37 (Red Hat Enterprise Linux)
Server built:   Dec  2 2019 14:15:24

@@ -124,7 +123,7 @@ https://www.terraform.io/docs/providers/google/r/compute_shared_vpc_host_project
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc fq_codel state UP group default qlen 1000
    link/ether 42:01:0a:00:02:06 brd ff:ff:ff:ff:ff:ff
 #   inet 10.0.2.6/32 scope global dynamic noprefixroute eth0
  **  inet 10.0.2.6/32 scope global dynamic noprefixroute eth0 **
       valid_lft 3414sec preferred_lft 3414sec
    inet6 fe80::da4c:58ee:efe9:beb/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
@@ -153,12 +152,12 @@ Server built:   Dec  2 2019 14:15:24
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc fq_codel state UP group default qlen 1000
    link/ether 42:01:0a:00:00:05 brd ff:ff:ff:ff:ff:ff
#     inet 10.0.0.5/32 scope global dynamic noprefixroute eth0
**    inet 10.0.0.5/32 scope global dynamic noprefixroute eth0. **
       valid_lft 2510sec preferred_lft 2510sec
    inet6 fe80::3f3b:65ab:59ee:2a14/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever



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
