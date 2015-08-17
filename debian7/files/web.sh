#!/bin/bash
# 
# Panel Sks INSTALLATION v3.0
# Web
#
# Created by Samas
#
# Copyright 2015 @ SKS.OVH. All rights reserved.

echo ""
echo "##################################################################"
echo "##                                                              ##"
echo "##                         PanelSKS                             ##"
echo "##                                                              ##"
echo "##                 Installation du serveur Web                  ##"
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

if [ -f /tmp/web.status ]
then
	echo "Le serveur Web est déjà installé !"
else
	echo "--- Installation des dépendances ---"
	echo ""

	echo ""
	echo "--- Installation de apache2 ---"
	echo ""
	# Vérifie si apache est déjà installer ou pas
	if [ $(verify_packet apache2) -eq 0 ]; then		
		apt-get install -y apache2
	else
		echo "Apache 2 : Ok"
	fi

	echo ""
	echo "--- Configuration de apache2 ---"
	echo ""
	echo "AddDefaultCharset UTF-8" > /etc/apache2/conf.d/charset
	a2enmod rewrite
	
	echo ""
	echo "--- Installation de Php ---"
	echo ""
	
	# Vérifie si php est déjà installer ou pas
	if [ $(verify_packet libapache2-mod-php5) -eq 0 ]; then		
		apt-get install -y libapache2-mod-php5
	else
		echo "Php : Ok"
	fi
	
	# Installation lier a php
	apt-get install -y php5-mysql	
	apt-get install -y php5-mcrypt
	
	# Curl
	read -p "Installer Curl ? (y/n): " curl
	if [[ "$curl" == "y" || "$curl" == "yes" || "$curl" == "Y" ]]
    then    	
		apt-get install -y curl
    fi
		
	# Curl
	read -p "Installer Ssh2 ? (y/n): " ssh2
	if [[ "$ssh2" == "y" || "$ssh2" == "yes" || "$ssh2" == "Y" ]]
    then    	
		apt-get install -y libssh2-1-dev
		apt-get install -y  libssh2-php
    fi
	
	echo ""
	echo "--- Configuration de php ---"
	echo ""
	sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php5/apache2/php.ini
	sed -i 's/display_errors = On/display_errors = Off/g' /etc/php5/apache2/php.ini
	sed -i 's/log_errors = Off/log_errors = On/g' /etc/php5/apache2/php.ini

	echo ""
	echo "--- Installation de MySQL ---"
	echo ""
	# Vérifie si le serveur mysql est déjà installer ou pas
	if [ $(verify_packet mysql-server) -eq 0 ]; then		
		apt-get install -y mysql-server
	else
		echo "Mysql : Ok"
	fi
	
	# Reboot Apache pour appliquer les modifications
	/etc/init.d/apache2 restart

	echo ""
	echo "--- Installation de PhpMyadmin ---"
	echo ""
	read -p "Installer PhpMyadmin? (y/n): " phpmyadmin
	if [[ "$phpmyadmin" == "y" || "$phpmyadmin" == "yes" || "$phpmyadmin" == "Y" ]]
    then
    	cd /tmp
		wget https://github.com/samas92i/panelsks/raw/master/ressources/phpmyadmin.tar.gz --no-check-certificate
		tar -xvzf phpmyadmin.tar.gz
		rm phpmyadmin.tar.gz
		mv phpmyadmin /var/www
    fi
    # Page PanelSKS
	cd /tmp
    wget https://raw.githubusercontent.com/samas92i/panelsks/master/index.html --no-check-certificate
    mv index.html /var/www

    echo ""
	echo "--- Fin de l'installation du serveur Web ---"	
fi