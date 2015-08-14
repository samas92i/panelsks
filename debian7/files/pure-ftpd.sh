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
echo "##                 Installation du serveur FTP                  ##"
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
	apt-get install -y openssl

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

	read -p "Entrez le mot de passe Root: " rootmysql
	echo ""
	read -p "Entrez le Port (3306 par défault): " portmysql
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
	service mysql restart

	echo ""
	echo "--- Création de la basse de donnée ---"
	echo ""

	# Récuperation du .sql
	cd /tmp
	wget https://raw.githubusercontent.com/samas92i/panelsks/master/install.sql --no-check-certificate
	mysql -u root -p "$rootmysql" -e 'CREATE DATABASE IF NOT EXISTS '"$bdd"'; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"%" IDENTIFIED BY "'"$password"'"; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"'"$ip"'" IDENTIFIED BY "'"$password"'"; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"localhost" IDENTIFIED BY "'"$password"'";'
	mysql -u root -p "$rootmysql" "$bdd" < /tmp/install.sql

	echo ""
	echo "--- Configuration du serveur FTP ---"
	echo ""

	# Fichier de config
	cd /tmp
	wget https://raw.githubusercontent.com/samas92i/panelsks/master/mysql.conf --no-check-certificate
	rm /etc/pure-ftpd/db/mysql.conf && mv mysql.conf /etc/pure-ftpd/db/mysql.conf
	sed -i "s/MYSQLPassword.*/MYSQLPassword $password /g" /etc/pure-ftpd/db/mysql.conf
	sed -i "s/MYSQLPort.*/MYSQLPort $portmysql /g" /etc/pure-ftpd/db/mysql.conf

	echo "1" > /etc/pure-ftpd/conf/TLS
	mkdir -p /etc/ssl/private/
	echo -e "\n\n\n\n\n\n" | openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem
	chmod 600 /etc/ssl/private/pure-ftpd.pem

	/etc/init.d/pure-ftpd-mysql restart
	echo ""
	echo "--- Fin de l'installation du serveur FTP ---"	
fi