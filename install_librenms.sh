#!/bin/bash
#
#         ========================  YouTube:  https://www.youtube.com/@linuxnetworkinghelp   =======================
#
#         =====================================  Please Subscribe   === 
# Update system
sudo apt update
sudo apt upgrade -y

# Install dependencies
sudo apt install -y apache2 composer fping git graphviz imagemagick libapache2-mod-php php php-cli php-curl php-fpm php-gd php-json php-mbstring php-mysql php-snmp php-xml php-zip python3-mysql.connector python3-pymysql python3-pyrrd rrdtool snmp snmpd whois

# Enable Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# Clone LibreNMS repository
sudo git clone https://github.com/librenms/librenms.git /opt/librenms
sudo chown -R www-data:www-data /opt/librenms
sudo chmod 771 /opt/librenms
cd /opt/librenms
sudo composer install --no-dev

# Configure Apache
sudo cp /opt/librenms/librenms.nonroot.conf /etc/apache2/sites-available/librenms.conf
sudo a2ensite librenms.conf
sudo systemctl reload apache2

# Configure LibreNMS
sudo cp /opt/librenms/config.php.default /opt/librenms/config.php
sudo chmod 644 /opt/librenms/config.php

# Initialize LibreNMS
sudo /opt/librenms/scripts/install.sh -u www-data -g www-data

# Add Cron Jobs
sudo cp /opt/librenms/librenms.nonroot.cron /etc/cron.d/librenms


echo "LibreNMS has been installed and configured."
