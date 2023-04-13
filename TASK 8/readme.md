Readme about 8 excercise.

link to my website http://34.69.126.112/, and second one where I had issue http://35.202.234.173/ (apache is working but wordpress not so I propose work aroung which is first link)

I didn't clear the repository because I didn't want to lose the previous knowledge. it was a mistake that cost me a lot of work and mistakes and it could be a reason why I didn't have apropriate amount of time in this task in quality what I expected.

How to instal wordpress ater built the infrastructure using terraform.

Task 8
1. I prepared CI/CD pipeline using github actions.
2. I did a architecutre diagram.
3. I prepared pros and cons each of possibility, details below:

Single VM
Pros:
    Simple and easy to set up
    Can be cost-effective for low-traffic sites
    Full control over the VM and the WordPress installation

Cons:
    Limited scalability
    Potential downtime if the VM fails or needs maintenance
    Manual scaling and management required as traffic increases

Kubernetes Cluster
Pros:
    High scalability and availability
    Kubernetes provides automated scaling and management
    Can be cost-effective for moderate to high-traffic sites

Cons:
    Complex to set up and manage
    Requires expertise in Kubernetes and containerization
    Potentially higher costs due to the need for multiple nodes

Cloud Run
Pros:
    Serverless and auto-scaling platform
    Can be cost-effective for low to moderate-traffic sites
    Easy to set up and manage
Cons:
    Limited control over the infrastructure and WordPress installation
    Limited to a maximum request timeout of 15 minutes
    Not suitable for high-traffic sites or those with high performance requirements

Cloud Function:
Cloud Functions for hosting a website is not a recommended approach because Cloud Functions are designed for event-driven, short-lived functions and are not intended for long-running applications like a website.
I didnt want to implement kubernetes - its too complicated in maintenance, also excluded cloud run becasue we didnt use this solution during our classes, but is quite good and have a huge scalability possibilities.

I choose Virtual Machine and Cloud SQL - MySQL Database with appropriate firewall rules. Virtual Machine could have albo scalability scripts to adapt to changing traffic, scale up or down depends on traffic.

4. I prepared terraform script with infrastructure - VM, Cloud SQL, and firewall rules for wordpress.
5. I configured wordpress.

Wordpress configuration:

1. Go to SSH of VM.
2. Instal Apache web server and php on the instance - VM.
sudo apt update
sudo apt install apache2
3. Download and extract the latest version of WordPress from the official website
- instal wget - is a command-line utility used to download files from the web usually linux systems
sudo apt-get update
sudo apt-get install wget - instal 
- download and extract the latest version of WordPress
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
4 Rename the wp-config-sample.php file to wp-config.php and edit it to include the database credentials for your existing MySQL database

mv wp-config-sample.php wp-config.php

5 Update wp-config.php
- Open the wp-config.php
- change directory:
cd /var/www/html
- Open VIM:
sudo vim wp-config.php

- update wp-config file and provide information about existing my Cloud SQL-MySQL database

define('DB_NAME', 'example');
define('DB_USER', 'user');
define('DB_PASSWORD', '********');
define('DB_HOST', '34.135.136.45');

6 Change permisions
sudo chown -R www-data:www-data /var/www/html/wordpress
suexampledo chmod -R 755 /var/www/html/wordpress

7 Restart apache2:
sudo service apache2 restart

I have some problem with open correct wordpress page and huge pressure of time so i created wordpress page from marketplace. I built infrastructure in IaaC approach, pipeline and my tf code work but setup of wordpress in VM didn't work. I strongly believe that in next couple days i will try to fix this setup of wordpress but i need to have more time.
