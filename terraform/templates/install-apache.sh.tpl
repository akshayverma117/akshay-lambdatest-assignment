#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Deployed via Terraform</h1>
<p>AWS Region: ${aws_ec2_region}</p>
<p>Project Environment: ${project_environment}</p>
<p>Project: ${project_platform}</p>" | sudo tee /var/www/html/index.html
