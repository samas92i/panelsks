#!/bin/bash
# 
# Panel Sks INSTALLATION v3.0
# SteamCMD
#
# Created by Samas
#
# Copyright 2015 @ SKS.OVH. All rights reserved.

echo "##################################################################"
echo "##                                                              ##"
echo "##                         PanelSKS                             ##"
echo "##                                                              ##"
echo "##                  Installation de SteamCMD                    ##"
echo "##                                                              ##"
echo "##################################################################"
echo ""

if [ -f /tmp/steamcmd.status ]
then
	echo "SteamCMD est déjà installé !"
else
	echo "--- Installation des dépendances ---"
	# Libs pour SteamCMD
	dpkg --add-architecture i386
	apt-get -y update
	apt-get -y dist-upgrade
	apt-get install -y ia32-libs
	# Libs pour Les jeux 
	apt-get install -y lib32gcc1
	apt-get install -y lib32stdc++6
	
	# Ajout des mis à jours experimental
	#echo "deb http://ftp.debian.org/debian sid main" >> /etc/apt/sources.list
	#apt-get -y update
	#apt-get -y dist-upgrade
	#apt-get -t sid install -y libc6 libc6-dev libc6-dbg
	
	# Création du dossier pour SteamCMD
	mkdir /home/panelsks/Steam
	chown panelsks:www-data /home/panelsks/Steam
	chmod 770 /home/panelsks/Steam
	
	echo ""
	echo "--- Téléchagement de SteamCMD ---"
	cd /home/panelsks/Steam
	wget https://ressources.sks.ovh/steam/steamcmd.tar.gz --no-check-certificate
	tar -xvzf steamcmd.tar.gz
	rm steamcmd.tar.gz

	# 1er lancement de SteamCMD
	su panelsks -c "cd /home/panelsks/Steam && ./steamcmd.sh +login anonymous +quit"
	
	echo ""
	echo "--- Fin de l'installation de SteamCMD ---"	
fi