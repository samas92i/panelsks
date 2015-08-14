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

if [ openjdk-7-jre -eq 0 ]
then
	echo "Java 7 est déjà installé !"
else
	apt-get install -y openjdk-7-jre
fi