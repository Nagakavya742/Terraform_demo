#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo service httpd start
sudo service httpd enable
echo "<h1>Welcome to terraform tutorial</h1>" > /var/www/html/index.html
yum install git -y