#!/bin/bash

sudo ip route add default via 192.168.1.1 dev eth1

# Variables
GLPI_URL="https://github.com/glpi-project/glpi/releases/download/10.0.18/glpi-10.0.18.tgz"
DB_ROOT_PASSWORD="rootpass"
GLPI_DB_NAME="glpidb"
GLPI_DB_USER="glpiuser"
GLPI_DB_PASSWORD="glpipass"
WEB_DIR="/var/www/html"

# Mise à jour du système
echo "Mise à jour du système..."
apt update && apt upgrade -y

# Installation des dépendances
echo "Installation d'Apache, MariaDB et PHP..."
apt install -y apache2 mariadb-server php php-{cli,common,mbstring,xmlrpc,mysql,gd,xml,ldap,zip,bz2,intl,curl,apcu,imagick} unzip wget tar

# Activation des modules Apache
echo "Activation des modules Apache..."
a2enmod rewrite
systemctl restart apache2

# Sécurisation de MariaDB et configuration de la base
echo "Configuration de la base de données..."
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
CREATE DATABASE $GLPI_DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER '$GLPI_DB_USER'@'localhost' IDENTIFIED BY '$GLPI_DB_PASSWORD';
GRANT ALL PRIVILEGES ON $GLPI_DB_NAME.* TO '$GLPI_DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

# Téléchargement et extraction de GLPI
echo "⬇️ Téléchargement de GLPI 10.0.18..."
cd /tmp
wget $GLPI_URL
tar -xvzf glpi-10.0.18.tgz
rm -rf $WEB_DIR/glpi
mv glpi $WEB_DIR/

# Droits sur le dossier
echo "Configuration des permissions..."
chown -R www-data:www-data $WEB_DIR/glpi
chmod -R 755 $WEB_DIR/glpi


# Fin
echo "Installation terminée !"
echo "Rendez-vous sur : http://<adresse-ip-ou-domaine>/glpi pour finir l'installation via l'interface web."

