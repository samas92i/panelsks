#!/bin/bash
#
# Panel INSTALLATION v3.0
# General
#
# Created by Samas
#
# Copyright 2015 @ SKS.OVH. All rights reserved.

echo ""
echo "##################################################################"
echo "##                                                              ##"
echo "##                         PanelSKS                             ##"
echo "##                                                              ##"
echo "##                   Installateur General                       ##"
echo "##                                                              ##"
echo "##################################################################"
echo ""

if [ -f /tmp/panelsks.status ]
then
	echo "Le panel est déjà installé !"
else
	# Installation du coeur
	wget https://raw.githubusercontent.com/samas92i/panelsks/master/debian7/files/core.sh --no-check-certificate
	chmod u+x core.sh
	./core.sh

	# Installation de SteamCMD
	echo ""
	read -p "Installer SteamCMD ? (y/n): " steamcmd
	if [[ "$steamcmd" == "y" || "$steamcmd" == "yes" || "$steamcmd" == "Y" ]]
    then
		wget https://raw.githubusercontent.com/samas92i/panelsks/master/debian7/files/steamcmd.sh --no-check-certificate
		chmod u+x steamcmd.sh
		./steamcmd.sh
    fi

	# Installation de Java 7
	echo ""
	read -p "Installer Java 7 ? (y/n): " java
	if [[ "$java" == "y" || "$java" == "yes" || "$java" == "Y" ]]
    then
		wget https://raw.githubusercontent.com/samas92i/panelsks/master/debian7/files/java.sh --no-check-certificate
		chmod u+x java.sh
		./java.sh
    fi
fi