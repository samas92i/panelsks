#!/bin/bash
# 
# Panel Sks INSTALLATION v3.0
# Ftp
#
# Created by Samas
#
# Copyright 2015 @ SKS.OVH. All rights reserved.

echo ""
echo "##################################################################"
echo "##                                                              ##"
echo "##                         PanelSKS                             ##"
echo "##                                                              ##"
echo "##                 Installation du serveur Ftp                  ##"
echo "##                                                              ##"
echo "##################################################################"
echo ""

# Vérifie si le packet passé en argument est installé
verify_packet () {
	if [ `dpkg-query -W --showformat='${Status}\n' $1 2>/dev/null | grep 'install ok installed' | wc -l` -ge 1 ]; then
		echo 1
	else
		echo 0
	fi
}

if [ -f /tmp/pureftps.status ]
then
	echo "Le serveur FTP est déjà installé !"
else
	echo "--- Installation des dépendances ---"
	echo ""
	# Vérifie si le serveur mysql est déjà installer ou pas
	if [ $(verify_packet mysql-server) -eq 0 ]; then		
		apt-get install -y mysql-server
	else
		echo "Mysql : Ok"
	fi

	# Vérifie si le serveur pure ftpd est déjà installer ou pas
	if [ $(verify_packet pure-ftpd) -eq 1 ]; then
		# Supprimer les dépendances est supprimer toutes les configurations
		apt-get remove --purge -y pure-ftpd
	fi
	
	# Vérifie si le serveur pure ftpd est déjà installer ou pas
	if [ $(verify_packet pure-ftpd-mysql) -eq 0 ]; then		
		apt-get install -y pure-ftpd-mysql
	else
		echo "Pure ftpd mysql : Ok"
	fi

	echo ""
	echo "--- Informations sur le serveur MySQL ---"
	echo ""
	read -p "Entrez le mot de passe ROOT: " rootmysql
	echo ""
	read -p "Entrez le PORT (3306 par défault): " portmysql
	# Variable lier à l'utilisateur pour le panel
	ip=$(hostname -i)
	username="panelsks"
	bdd="panelsks"
	password=$(date | md5sum | head -c 15)

	echo ""
	echo "--- Configuration du serveur MySQL ---"
	echo ""
	# Rend la bdd disponible à distance (pour le panel)
	sed -i 's/bind-address/#bind-address/g' /etc/mysql/my.cnf

	echo ""
	echo "--- Création de la basse de donnée ---"
	echo ""
	# Récuperation du .sql
	cd /tmp
	wget https://ressources.sks.ovh/install.sql --no-check-certificate
	mysql -u root -p"$rootmysql" -e 'CREATE DATABASE IF NOT EXISTS '"$bdd"'; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"%" IDENTIFIED BY "'"$password"'"; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"'"$ip"'" IDENTIFIED BY "'"$password"'"; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"localhost" IDENTIFIED BY "'"$password"'";'
	mysql -u root -p"$rootmysql" "$bdd" < /tmp/install.sql

	echo ""
	echo "--- Configuration du serveur Ftp ---"
	echo ""
fi