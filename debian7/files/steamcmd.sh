#!/bin/bash
# 
# Panel Sks INSTALLATION v3.0
# SteamCMD
#
# Created by Samas
#
# Copyright 2015 @ SKS.OVH. All rights reserved.

echo ""
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
	echo ""
	# Libs pour SteamCMD
	dpkg --add-architecture i386
	apt-get -y update
	apt-get -y upgrade
	apt-get -y dist-upgrade
	apt-get install -y ia32-libs
	# Libs pour les jeux 
	apt-get install -y lib32gcc1
	apt-get install -y lib32stdc++6
	
	# Ajout des mis à jour experimental
	#echo "deb http://ftp.debian.org/debian sid main" >> /etc/apt/sources.list
	#apt-get -y update
	#apt-get -y dist-upgrade
	#apt-get -t sid install -y libc6 libc6-dev libc6-dbg
	
	# Création du dossier pour SteamCMD
	mkdir /home/panelsks/Steam
	chown panelsks:panelsks /home/panelsks/Steam
	chmod 770 /home/panelsks/Steam
	
	echo ""
	echo "--- Téléchagement de SteamCMD ---"
	echo ""
	cd /home/panelsks/Steam
	wget https://github.com/samas92i/panelsks/raw/master/ressources/steamcmd.tar.gz --no-check-certificate
	tar -xvzf steamcmd.tar.gz
	rm steamcmd.tar.gz

	# 1er lancement de SteamCMD
	read -p "Login Steam: " login
	echo ""
	read -p "Mot de passe: " pass
	su panelsks -c "cd /home/panelsks/Steam && ./steamcmd.sh +login "$login" "pass" +quit"
	
	# Fichier de protection
	echo "installed" > /tmp/steamcmd.status
	echo ""
	echo "--- Fin de l'installation de SteamCMD ---"	
fi