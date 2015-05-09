#!/bin/bash
#
# Panel SKS
# Remote Scripts v0.1
#
# Installation Script
# NOTE: By Samas
#
#
echo "##################################################################"
echo "##                                                              ##"
echo "##                         PanelSKS                             ##"
echo "##                                                              ##"
echo "##                   Instalteur Panel SKS                       ##"
echo "##                                                              ##"
echo "##################################################################"

user="panelsks"
user_home="/home/panelsks"

if [ "$UID" -ne "0" ]
then
    echo "ERROR: Vous devez etre en temps que root."
    exit
fi

echo "##### Update #####"
apt-get -y update
apt-get -y upgrade
echo ""

echo "##### Install #####"
apt-get -y install default-jdk
apt-get -y install screen
echo ""

echo "java" > $user_home/panelsks
chown $user: $user_home -R

#############################################################################################################

echo
echo
echo "##################################################################"
echo
echo "Instalation du PanelSks terminer."
echo
echo "##################################################################"
