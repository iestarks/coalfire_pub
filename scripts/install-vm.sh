#!/bin/bash

sudo yum install httpd -y

sudo yum update -y

sudo service httpd start

sudo chkconfig httpd on
