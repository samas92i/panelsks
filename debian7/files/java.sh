#!/bin/bash
# 
# Panel Sks INSTALLATION v3.0
# Java
#
# Created by Samas
#
# Copyright 2015 @ SKS.OVH. All rights reserved.

echo ""
echo "##################################################################"
echo "##                                                              ##"
echo "##                         PanelSKS                             ##"
echo "##                                                              ##"
echo "##                   Installation de Java 7                     ##"
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

if [ $(verify_packet openjdk-7-jre) -eq 1 ]
then
	echo "Java 7 est déjà installé !"
else
	apt-get install -y openjdk-7-jre
fi