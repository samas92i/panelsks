#!/bin/bash
# 
# Panel Sks INSTALLATION v3.0
# Core
#
# Created by Samas
#
# Copyright 2015 @ SKS.OVH. All rights reserved.

echo ""
echo "##################################################################"
echo "##                                                              ##"
echo "##                         PanelSKS                             ##"
echo "##                                                              ##"
echo "##                   Installation du Coeur                      ##"
echo "##                                                              ##"
echo "##################################################################"
echo ""

if [ -f /tmp/core.status ]
then
	echo "Le coeur est déjà installé !"
else
	echo "---- Mis à jour des sources ---"
	echo ""
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
	echo "--- Mis à jour ---"
	echo ""
	apt-get -y update
	apt-get -y upgrade
	apt-get -y dist-upgrade

	echo ""
	echo "--- Installation des dépendances ---"
	echo ""
	apt-get install -y sudo
	apt-get install -y screen
	apt-get install -y nano
	apt-get install -y zip
	apt-get install -y htop

	echo ""
	echo "--- Création de l'utilisateur est du group ---"
	echo ""
	useradd -m -p -u 5042 LOCKED panelsks
	usermod -a -G panelsks panelsks

	echo ""
	echo "--- Création des dossiers ---"
	echo ""
	mkdir /home/panelsks/ressources
	mkdir /home/panelsks/serveurs
	mkdir /home/panelsks/back_up

	echo ""
	echo "--- Permissions ---"
	echo ""
	# Ajout de l'utisateur aux dossiers
	chown panelsks:panelsks /home/panelsks/ressources	
	chown panelsks:panelsks /home/panelsks/serveurs
	chown panelsks:panelsks /home/panelsks/back_up
	# Changement des permissions
	chmod 770 /home/panelsks/ressources
	chmod 770 /home/panelsks/back_up

	echo ""
	echo "--- SSH ---"
	echo ""
	# Clée ssh
	ssh1="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNH+Rmp5fIZTt2UjNjpTreft2K5BI/ZB9NFucc6N9lP9Ir1NMp61NnbnJXtmz3O6Lu5UVxeRORnBlXDOh7xgbMv1DqyZoYAwH4nc3e/bgiMucCM2g1hnTs5i+ls89CQnSGvCIHlQyg8HQsxl0QWNjgYMNRMsRaX5rCV8ZKm9Ln5y48+rRrOTzosEbZdgDFVx5H271PREoWKsLv+cq/R2kUplEjapfy3xfNFEMQP0xxkHKYn9S2XaC0d4glZ8MhFgMqH3/aL1v3xukN9pQsH5tBprQp3oGcRwp5kpZZFOO4uqk1y3xz3ox5cFKMzH+YFSWwKP/oHDMylfjpO4A2v89maNe4sDgGhslaLjZZ6AFu8g65HN9rKgNYsf0H55hhCnz11Fq3wR8Ua7h/pUrQITs8LWTFCO1eu75SwqKzOfVqihYzYKwTHTIcxIxUjQosROF41V+xyZeqy+xg/vOL6oVy+tegjAGuukTwhkVbCzjgkIidOg+5FVg2EPWbuqnazOrE7jE9ZaPc907ubWSJov+ae7TpzuvahZrvPmnRWOtFGs2COS+TRRX6MEG7tbzKVzvZCOamNj3sB8I1e9LXBv628q9tcv7RLs70UjPgOSVmO1YHm4gLQni02+p5nhiK943agYSIt3YhzEqs50nGPDeLBo7hNJZbOftaqvqWTDsJgQ== samas92i@web"
	ssh2="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDv4FfL+AUVg38AbH2o42b34Fj84G753kEy+TdgG6s2KdCaxLUHKW+aCEvLnM6TcKbt+AZYq/uAn3LM87vNhjBuvGf8xNIz/l1ZHFbZL9o0hDQvj8DpFKlKRrj5uBgcbzbLV0Y1fKJPRcffnseoYj5WJkQFMdcYiP70jLy4RkivfvwjS0qdngXzYWmB8qdIZ8V2lp9z49+IAxfCrJl6RKttfGooEbjlPA0/06Pfsoh/JKthdV/WsecwW8XtbhOB+i1fvq4FCcMKSEkJtmbzPttundTLQmcvI22AE4GXydAa/jfFNuZ1pEVyC9LVvBfQl9BdgO4hqN5NA0g0Kv6HwJqCxScAiqsRj7dFFiDOnV+8FM20tTodxnqF42T1g/ST46erLaeyWdQ9im7hNCFrSdT3dNz2RTOB36ROee/+BqZD+iwVw35oFbIeZTm2Y3Y3JMo37U2APGEtlEdwI93zyy4qjgLpX0L8FXY8UKpFuJkLqetY1bYCla7uTva+v8maYQv/cNJZscQ2Ozf/RaK6Z19COsSWOTM2oeVN5blYZ7bAtJNxnV15fnSDCAPlsqFDEgLumjzs1/4GSYA2LGiyiGpiFAkeW8QRoLyqNFAs873siVhznMK10XbtqznMGIFXvYm9weqWgBw4Zqelhf43b/oyqWjvWsmhZi5n+SKiUd6j5w== panelsks@web"
	ssh3="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmjr6QoEdLQjJdVreHrhV4+55xS5N+Rlz7lXzLPGK6qSQ6BbbxcL5is70Ugec/KnZjtgEwCEWXTHvIk2pu5jcYIxKcpkM7/13EjheIp5aT6IccVD0ZCFoNBDSMbg5ryR8jDdVlEU4Ff4i3cT+W3rxF9574g6gdzFSdY+RaeoHym4QnOlJ83HVThjslsDdmQ5jpYOl1LYEyZK5ssM3tAN6vmqu8GJRkbQru6LSpvYcplZHjV5C0Q4O8D1cPcuUUhN0s5EB7MT96PieG2YYk5rtUvAAJnBuG/zZiHbJeZUBGn2uTgOD6MMQe8ZoelLfldakuGqN4BRjB1+7wZKEWlfwVV3Q5luWYaDNc+rVpNqN9rXiogwUH0RFdl5qKj1jSZT4Gp+Q9MDYw9ve4ttbL+qeAoVPSe+6uQlfXrcVszTSkj4NCKyZ8K8lZ5Ia64FMGNEJJQ4HDMam7YLW7ed91kklHgMM6bTgd3tqVRrZtBXDejgtA7xrVqtK/f6yTHU9PV5o1NdkSSXeUdc8nO/4CQOVus0UnLrXKeURnxsZ55B6Jkh56Awgu5dGkKNv6lLDgPiDX1xr9i2/3g8GUtcNobj7LJ4xCf4lJHnubPCsQteV0JeGqFPetAaRu5Ec12NepTRf/L0BGalaf+Pu8mFyLPJFDdlTKa126b4gDcnSvPEZMAQ== sync@web"
	
	# Ajout de la clée pour le root (support)
	mkdir /root/.ssh
	{ 
	  echo "$ssh1"
	} >> /root/.ssh/authorized_keys
	
	# Ajout des clées pour le panel 
	mkdir /home/panelsks/.ssh	
	{	
	  echo "$ssh2"
	  echo "$ssh3"	
	} >> /home/panelsks/.ssh/authorized_keys

	# Fichier de protection
	echo "installed" > /tmp/core.status	
	echo ""
	echo "--- Fin de l'installation du Coeur ---"
fi