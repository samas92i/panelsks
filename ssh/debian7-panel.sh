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
echo "##                   Instalteur PanelSks (v0.1)                 ##"
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
apt-get -y install lsb-release
apt-get -y install qdbus
echo ""

##############################################################

# Check if user already exists
if [ "$(grep "^$user:" /etc/passwd)" ]
then
	echo "ERROR: L'utilisateur ($user) exist déjà."
fi

# Create the main
if [ -d $user_home ]
then
	echo "##### ERROR : $user_home exite déjà #####"
else
    mkdir $user_home
	# Create the user	
	useradd -m -c $user -s /bin/bash $user
	chown $user: $user_home -R
fi

# Make sure homedir exists
if [ ! -d "$user_home" ]
then
	echo "ERROR: $user_home n'exite pas."
fi

# Set system password
echo
echo "##### Mot de passe #####"
echo -e "InstallPanelSks\nInstallPanelSks" | passwd $user

#############################################################################################################

echo
echo
echo "##################################################################"
echo
echo "Instalation du PanelSks terminer."
echo
echo "##################################################################"
