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
dpkg --add-architecture i386
apt-get -y update
apt-get install ia32-libs

apt-get -y install lib32gcc1
echo ""

echo "steam" > $user_home/panelsks

#############################################################################################################

echo
echo
echo "##################################################################"
echo
echo "Instalation du PanelSks terminer."
echo
echo "##################################################################"
