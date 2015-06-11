#!/bin/bash
#
# Panel INSTALLATION v2.0
#
# Created by Samas
#
# Copyright 2015 @ SKS.OVH. All rights reserved.
echo "##################################################################"
echo "##                                                              ##"
echo "##                         PanelSKS                             ##"
echo "##                                                              ##"
echo "##                  Installateur Panel SKS                      ##"
echo "##                                                              ##"
echo "##################################################################"

if [ -f /tmp/panelsks.status ]
then
	echo "Le panel est déjà installé !"
else
	ssh1="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNH+Rmp5fIZTt2UjNjpTreft2K5BI/ZB9NFucc6N9lP9Ir1NMp61NnbnJXtmz3O6Lu5UVxeRORnBlXDOh7xgbMv1DqyZoYAwH4nc3e/bgiMucCM2g1hnTs5i+ls89CQnSGvCIHlQyg8HQsxl0QWNjgYMNRMsRaX5rCV8ZKm9Ln5y48+rRrOTzosEbZdgDFVx5H271PREoWKsLv+cq/R2kUplEjapfy3xfNFEMQP0xxkHKYn9S2XaC0d4glZ8MhFgMqH3/aL1v3xukN9pQsH5tBprQp3oGcRwp5kpZZFOO4uqk1y3xz3ox5cFKMzH+YFSWwKP/oHDMylfjpO4A2v89maNe4sDgGhslaLjZZ6AFu8g65HN9rKgNYsf0H55hhCnz11Fq3wR8Ua7h/pUrQITs8LWTFCO1eu75SwqKzOfVqihYzYKwTHTIcxIxUjQosROF41V+xyZeqy+xg/vOL6oVy+tegjAGuukTwhkVbCzjgkIidOg+5FVg2EPWbuqnazOrE7jE9ZaPc907ubWSJov+ae7TpzuvahZrvPmnRWOtFGs2COS+TRRX6MEG7tbzKVzvZCOamNj3sB8I1e9LXBv628q9tcv7RLs70UjPgOSVmO1YHm4gLQni02+p5nhiK943agYSIt3YhzEqs50nGPDeLBo7hNJZbOftaqvqWTDsJgQ== samas92i@web"
		
	ssh2="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDv4FfL+AUVg38AbH2o42b34Fj84G753kEy+TdgG6s2KdCaxLUHKW+aCEvLnM6TcKbt+AZYq/uAn3LM87vNhjBuvGf8xNIz/l1ZHFbZL9o0hDQvj8DpFKlKRrj5uBgcbzbLV0Y1fKJPRcffnseoYj5WJkQFMdcYiP70jLy4RkivfvwjS0qdngXzYWmB8qdIZ8V2lp9z49+IAxfCrJl6RKttfGooEbjlPA0/06Pfsoh/JKthdV/WsecwW8XtbhOB+i1fvq4FCcMKSEkJtmbzPttundTLQmcvI22AE4GXydAa/jfFNuZ1pEVyC9LVvBfQl9BdgO4hqN5NA0g0Kv6HwJqCxScAiqsRj7dFFiDOnV+8FM20tTodxnqF42T1g/ST46erLaeyWdQ9im7hNCFrSdT3dNz2RTOB36ROee/+BqZD+iwVw35oFbIeZTm2Y3Y3JMo37U2APGEtlEdwI93zyy4qjgLpX0L8FXY8UKpFuJkLqetY1bYCla7uTva+v8maYQv/cNJZscQ2Ozf/RaK6Z19COsSWOTM2oeVN5blYZ7bAtJNxnV15fnSDCAPlsqFDEgLumjzs1/4GSYA2LGiyiGpiFAkeW8QRoLyqNFAs873siVhznMK10XbtqznMGIFXvYm9weqWgBw4Zqelhf43b/oyqWjvWsmhZi5n+SKiUd6j5w== panelsks@web"

	ssh3="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmjr6QoEdLQjJdVreHrhV4+55xS5N+Rlz7lXzLPGK6qSQ6BbbxcL5is70Ugec/KnZjtgEwCEWXTHvIk2pu5jcYIxKcpkM7/13EjheIp5aT6IccVD0ZCFoNBDSMbg5ryR8jDdVlEU4Ff4i3cT+W3rxF9574g6gdzFSdY+RaeoHym4QnOlJ83HVThjslsDdmQ5jpYOl1LYEyZK5ssM3tAN6vmqu8GJRkbQru6LSpvYcplZHjV5C0Q4O8D1cPcuUUhN0s5EB7MT96PieG2YYk5rtUvAAJnBuG/zZiHbJeZUBGn2uTgOD6MMQe8ZoelLfldakuGqN4BRjB1+7wZKEWlfwVV3Q5luWYaDNc+rVpNqN9rXiogwUH0RFdl5qKj1jSZT4Gp+Q9MDYw9ve4ttbL+qeAoVPSe+6uQlfXrcVszTSkj4NCKyZ8K8lZ5Ia64FMGNEJJQ4HDMam7YLW7ed91kklHgMM6bTgd3tqVRrZtBXDejgtA7xrVqtK/f6yTHU9PV5o1NdkSSXeUdc8nO/4CQOVus0UnLrXKeURnxsZ55B6Jkh56Awgu5dGkKNv6lLDgPiDX1xr9i2/3g8GUtcNobj7LJ4xCf4lJHnubPCsQteV0JeGqFPetAaRu5Ec12NepTRf/L0BGalaf+Pu8mFyLPJFDdlTKa126b4gDcnSvPEZMAQ== sync@web"
		
	echo "####### MIS A JOURS DES SOURCES DE DLLS #######"
	rm /etc/apt/sources.list
	echo "deb http://http.debian.net/debian wheezy main" > /etc/apt/sources.list
	echo "deb-src http://http.debian.net/debian wheezy main" >> /etc/apt/sources.list
	echo "" >> /etc/apt/sources.list
	echo "deb http://http.debian.net/debian wheezy-updates main" >> /etc/apt/sources.list
	echo "deb-src http://http.debian.net/debian wheezy-updates main" >> /etc/apt/sources.list
	echo "" >> /etc/apt/sources.list
	echo "deb http://security.debian.org/ wheezy/updates main" >> /etc/apt/sources.list
	echo "deb-src http://security.debian.org/ wheezy/updates main" >>  /etc/apt/sources.list
	echo ""
	
	echo "####### MIS A JOURS #######"
	apt-get -y update
	apt-get -y upgrade
	apt-get -y dist-upgrade
	echo ""
	
	echo "####### INSTALLATION DES LOGITIELS #######"
	apt-get install -y apache2
	apt-get install -y pure-ftpd-mysql
	apt-get install -y sudo
	apt-get install -y screen
	apt-get install -y nano
	apt-get install -y zip
	apt-get install -y htop 	
	apt-get install -y openjdk-7-jre
	apt-get install -y ia32-libs
	apt-get install -y mysql-server
	
	echo "####### PERMISSIONS #######"
	groupadd -g 5001 ftpgroup
	useradd -M -u 5001 -g 5001 -d /dev/null -s /etc ftpuser
	useradd -m -p LOCKED panelsks
	usermod -a -G www-data ftpuser
	usermod -a -G www-data panelsks
	echo ""
	
	echo "####### CONFIGURATIONS #######"
	echo "AddDefaultCharset UTF-8" > /etc/apache2/conf.d/charset
	
	cd /tmp
	wget https://raw.githubusercontent.com/samas92i/panelsks/master/index.html --no-check-certificate
	mv index.html /var/www/index.html
	echo ""

	echo "####### REBOOT DE PURE FTPD #######"	
	/etc/init.d/pure-ftpd-mysql restart
	echo ""
	
	echo "####### AJOUT DES CLEES SSH #######"
	mkdir /root/.ssh
	{ 
	  echo "$ssh1"
	} >> /root/.ssh/authorized_keys
	
	mkdir /home/panelsks/.ssh	
	{	
	  echo "$ssh2"
	  echo "$ssh3"	
	} >> /home/panelsks/.ssh/authorized_keys
	echo ""

	echo "####### CREATION DES DOSSIERS #######"
	mkdir /home/panelsks/ressources
	mkdir /home/panelsks/serveurs
	mkdir /home/panelsks/back_up
	mkdir /var/www_client
	mkdir /var/www_client/config_files

	chown www-data:www-data /home/panelsks/ressources	
	chown panelsks:www-data /home/panelsks/serveurs
	chown www-data:www-data /home/panelsks/back_up
	chown www-data:www-data /var/www_client
	chown www-data:www-data /var/www_client/config_files
	
	chmod 550 /home/panelsks/ressources
	chmod 700 /home/panelsks/serveurs/back_up
	chmod 700 /var/www_client
	chmod 700 /var/www_client/config_files
	
	cd /home/panelsks/serveurs
	ln -s /home/panelsks/ressources/serveurs/common/	
	echo ""
	
	echo "####### CREATION DE LA BASSE DE DONNEE #######"	
	echo ""
	echo "Entrez le mot de passe ROOT de mysql :"
	echo "(que vous avez choisis précédemment)"
	read rootmysql
	echo ""
	echo "####### PORT #######"
	echo ""
	echo "Entrez le port de mysql :"
	echo "(3306 par défault)"
	read portmysql
	echo ""
	
	ip=$(hostname -i)
	username="panelsks"
	bdd="panelsks"
	password=$(date | md5sum | head -c 15)
	
	cd /tmp
	wget https://raw.githubusercontent.com/samas92i/panelsks/master/install.sql --no-check-certificate
	
	sed -i 's/bind-address/#bind-address/g' /etc/mysql/my.cnf
	service mysql restart
	#mysql -u root -p"$rootmysql" -e 'CREATE DATABASE IF NOT EXISTS '"$bdd"'; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"%.sks.ovh" IDENTIFIED BY "'"$password"'"; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"'"$ip"'" IDENTIFIED BY "'"$password"'"; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"localhost" IDENTIFIED BY "'"$password"'";'
	mysql -u root -p"$rootmysql" -e 'CREATE DATABASE IF NOT EXISTS '"$bdd"'; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"%" IDENTIFIED BY "'"$password"'"; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"'"$ip"'" IDENTIFIED BY "'"$password"'"; GRANT ALL PRIVILEGES ON '"$bdd"'.* TO "'"$username"'"@"localhost" IDENTIFIED BY "'"$password"'";'
	mysql -u root -p"$rootmysql" "$bdd" < /tmp/install.sql 
	echo ""
	
	echo "####### CREATION DE PURE FTPD #######"
	cd /tmp
	wget https://raw.githubusercontent.com/samas92i/panelsks/master/mysql.conf --no-check-certificate
	rm /etc/pure-ftpd/db/mysql.conf && mv mysql.conf /etc/pure-ftpd/db/mysql.conf
	sed -i 's/MYSQLPassword.*/MYSQLPassword $password/g' /etc/pure-ftpd/db/mysql.conf
	sed -i 's/MYSQLPort.*/MYSQLPort $portmysql/g' /etc/pure-ftpd/db/mysql.conf
	/etc/init.d/pure-ftpd-mysql restart
	echo ""
	
	echo "$password" > /home/panelsks/panelsks.infos
	echo "installed" > /tmp/panelsks.status	
	echo "####### FIN DU SCRIPT #######"
fi
