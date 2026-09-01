#!/bin/bash

# SELinux Access Denial Practical
# Student Name: 1U24IT051
# Register Number: KAMALI K

echo "===== SELinux Status ====="
getenforce 
sestatus

echo "===== Creating Web Directory ====="
sudo mkdir -p /web
sudo chmod 755 /web
echo "===== Creating HTML File ====="
echo "<html><body><h1>SELinux Practical</h1></body></html>" | sudo tee /web/index.html > /dev/null 
sudo chmod 644 /web/index.html

echo "===== Setting Linux Permissions ====="
sudo chown -R root:root /web 
sudo chmod 755 /web 
sudo chmod 644 /web/index.html
ls -l /web

echo "===== Checking Initial Context ====="
ls -Zd /web ls -Z /web/index.html

echo "===== Assigning Wrong SELinux Context ====="
sudo chcon -t user_home_t /web/index.html
echo "===== Checking Wrong Context ====="
ls -Z /web/index.html

echo "===== Checking AVC Denials ====="
sudo ausearch -m AVC -ts recent 2>/dev/null | tail -20
echo "===== Correcting SELinux Context ====="
sudo chcon -t httpd_sys_content_t /web/index.html

echo "===== Checking Correct Context ====="
ls -Z /web/index.html
echo "===== Practical Completed ====="
echo "The SELinux context was intentionally changed to an incorrect type"
echo "and then corrected to httpd_sys_content_t."
