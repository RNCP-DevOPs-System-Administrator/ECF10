#!/bin/bash

# Serveur Nagios
NAGIOS_SERVER_IP="192.168.1.4"


echo "Mise à jour du système..."
sudo apt update && sudo apt upgrade -y

echo "Installation de NRPE et plugins Nagios..."
sudo apt install -y nagios-nrpe-server nagios-plugins iproute2 net-tools

echo "Configuration de NRPE..."
NRPE_CFG="/etc/nagios/nrpe.cfg"

# Sauvegarde de l'original
sudo cp $NRPE_CFG ${NRPE_CFG}.bak

# Autoriser le serveur Nagios à se connecter
sudo sed -i "s/^allowed_hosts=.*/allowed_hosts=127.0.0.1,${NAGIOS_SERVER_IP}/" $NRPE_CFG

# Vérifier ou ajouter quelques commandes utiles si absentes
sudo grep -q "command\[check_users\]" $NRPE_CFG || echo 'command[check_users]=/usr/lib/nagios/plugins/check_users -w 5 -c 10' | sudo tee -a $NRPE_CFG
sudo grep -q "command\[check_load\]" $NRPE_CFG || echo 'command[check_load]=/usr/lib/nagios/plugins/check_load -w 5.0,4.0,3.0 -c 10.0,6.0,4.0' | sudo tee -a $NRPE_CFG
sudo grep -q "command\[check_mem\]" $NRPE_CFG || echo 'command[check_mem]=/usr/lib/nagios/plugins/check_mem' | sudo tee -a $NRPE_CFG
sudo grep -q "command\[check_http\]" $NRPE_CFG || echo 'command[check_http]=/usr/lib/nagios/plugins/check_http -H 192.168.1.3' | sudo tee -a $NRPE_CFG
sudo grep -q "command\[check_disk\]" $NRPE_CFG || echo 'command[check_disk]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /' | sudo tee -a $NRPE_CFG
sudo grep -q "command\[check_procs\]" $NRPE_CFG || echo 'command[check_procs]=/usr/lib/nagios/plugins/check_procs -w 150 -c 200' | sudo tee -a $NRPE_CFG

echo "Redémarrage du service NRPE..."
sudo systemctl restart nagios-nrpe-server
sudo systemctl enable nagios-nrpe-server

echo "Vérification de l’écoute sur le port 5666..."
sudo ss -tunlp | grep 5666 || echo "Le port 5666 ne semble pas ouvert !"

echo "Installation terminée."
echo "L'agent NRPE est installé et prêt à communiquer avec le serveur Nagios à ${NAGIOS_SERVER_IP}"
