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
	wget https://raw.githubusercontent.com/samas92i/panelsks/master/debian7/filles/core.sh --no-check-certificate
	chmod +x core.sh

	# Installation de SteamCMD
	echo ""
	read -p "Installer SteamCMD ? (y/n): " rootmysql
	if [[ "$gpx_ok_gentoo" == "y" || "$gpx_ok_gentoo" == "yes" || "$gpx_ok_gentoo" == "Y" ]]
    then
		wget https://raw.githubusercontent.com/samas92i/panelsks/master/debian7/filles/steamcmd.sh --no-check-certificate
		chmod +x steamcmd.sh
    fi
fi