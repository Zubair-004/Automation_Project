# Automation_Project


This script performs the following tasks,
- Performs an update of the package details and the package list at the start of the script
- Installs the apache2 package if it is not already installed
- Ensures that the apache2 service is running
- Ensures that the apache2 service is enabled
- Creates a tar archive of apache2 access logs and error logs that are present in the /var/log/apache2/ directory and places the tar into the /tmp/ directory
- Runs the AWS CLI command and copies the archive to the s3 bucket

