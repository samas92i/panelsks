#!/bin/bash
### BEGIN INIT INFO
# Provides:   minecraft
# Required-Start: $local_fs $remote_fs
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network
# Should-Stop:    $network
# Default-Start:  2 3 4 5
# Default-Stop:   0 1 6
# Short-Description:    Script Harmony-Hosting Minecraft
# Description:    Init script pour un serveur minecraft
### END INIT INFO

# # # # # # # # # # # # # # # # # # # # #
# CONFIGURATION CLIENT                  #
# # # # # # # # # # # # # # # # # # # # #

#Ram MAX (en pourcentage)
RAM="10"

#Nom du serveur
SCREEN="minecraft_server"
#Chemin du serveur
MCPATH="/home/minecraft/"
#Chemin des sauvegardes
BACKUPPATH="/home/panelsks/minecraft_backups/"

# # # # # # # # # # # # # # # # # # # # # #
# CONFIGURATION SYSTEME - NE PAS TOUCHER  #
# # # # # # # # # # # # # # # # # # # # # #
USERNAME="panelsks"
SERVICE=`ls $MCPATH | grep .jar | head -n 1`
CPU_COUNT=`cat /proc/cpuinfo | grep -c ^processor`;

LOGPATH="${BACKUPPATH}/logs/"
WHOLEBACKUP="${BACKUPPATH}/server/"
WORLBACKUPPATH="${BACKUPPATH}/worlds/"
BACKUPFORMAT="tar"
WORLDSTORAGE="${MCPATH}"

MAX_MEMORY=`free -m -t | grep "^Mem:" | awk '{print $2}'`;
XMX=$(($MAX_MEMORY / 100 * $RAM ))
XMS=$((XMX / 8))

JAVA_COMMAND="java -Dfile.encoding=UTF8 ";
JAVA_COMMAND=$JAVA_COMMAND"-Xmx"$XMX"m ";
JAVA_COMMAND=$JAVA_COMMAND"-Xms"$XMS"m ";
JAVA_COMMAND=$JAVA_COMMAND"-XX:+UseConcMarkSweepGC ";
JAVA_COMMAND=$JAVA_COMMAND"-XX:+CMSIncrementalPacing ";
JAVA_COMMAND=$JAVA_COMMAND"-XX:MaxPermSize=128M "
JAVA_COMMAND=$JAVA_COMMAND"-XX:ParallelGCThreads="$CPU_COUNT" ";
JAVA_COMMAND=$JAVA_COMMAND"-XX:+AggressiveOpts ";
JAVA_COMMAND=$JAVA_COMMAND"-jar $SERVICE ";
INVOCATION=`echo $JAVA_COMMAND`

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Chown du dossier MC a chaque lancement
chown -R minecraft:minecraft $MCPATH
chown -R minecraft:minecraft $BACKUPPATH

# Declaration des couleurs :
VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
ROSE="\\033[1;35m"
BLEU="\\033[1;34m"
BLANC="\\033[0;02m"
BLANCLAIR="\\033[1;08m"
JAUNE="\\033[1;33m"
CYAN="\\033[1;36m"

ME=`whoami`
as_user() {
   if [ $ME == $USERNAME ] ; then
      bash -c "$1"
   else
      su $USERNAME -s /bin/bash -c "$1"
   fi
}

is_running() {
   if ps ax | grep -v grep | grep "$SCREEN" > /dev/null
   then
      return 0
   fi
   return 1
}

datepath() {
   # $1 filepath (not including file ending)
   # $2 file ending to check for uniqueness
   # $3 file ending to return

   if [ -e $1`date +%F`$2 ]
   then
      echo $1`date +%FT%T`$3
   else
      echo $1`date +%F`$3
   fi
}

mc_start() {
   cd $MCPATH
   as_user "cd $MCPATH && screen -dmS $SCREEN $INVOCATION"
   #Wait starting ..
   seconds=0
   until ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
   do
      sleep 1 
      seconds=$seconds+1
      if [[ $seconds -eq 5 ]]
      then
         echo "Minecraft n'est toujours pas lance.. On attend encore un peu.."
      fi
      if [[ $seconds -ge 120 ]]
      then
         echo -e "$ROUGE Minecraft n'a pas pu demarre. $NORMAL"
         exit 1
      fi
   done   
   echo -e "$VERT Minecraft a demarre. $NORMAL"
}

mc_saveoff() {
   if is_running
   then
      echo -e "$VERT Minecraft est demarre. Desactivation des sauvegardes automatiques. $NORMAL"
      as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"save-off\"\015'"
      as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"save-all\"\015'"
      sync
      sleep 10
   else
      echo -e "$VERT Minecraft n'est pas demarre. Pas de desactivation sauvegardes automatiques. $NORMAL"
   fi
}

mc_saveon() {
   if is_running
   then
      echo -e "$VERT Minecraft est demarre. Re-activation des sauvegardes automatiques. $NORMAL"
      as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"save-on\"\015'"
   else
      echo -e "$ROUGE Minecraft n'est pas demarre. Pas de re-activation des sauvegardes automatiques. $NORMAL"
   fi
}

mc_command() {
   if is_running
   then
      as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"$1\"\015'"
   else
      echo -e"$ROUGE Minecraft n'est pas demarre. Impossible de dire quelque chose. $NORMAL"
   fi
}

mc_stop() {
   #
   # Stops the server
   #
   echo -e "$CYAN Sauvegarde des mondes. $NORMAL"
   as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"save-all\"\015'"
   sleep 10
   echo -e "$VERT Arret de Minecraft $NORMAL"
   as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"stop\"\015'"
   sleep 0.5
   #
   # Waiting for the server to shut down
   #
   seconds=0
   while ps ax | grep -v grep | grep -v -i SCREEN | grep $SERVICE > /dev/null
   do
      sleep 1 
      seconds=$seconds+1
      if [[ $seconds -eq 5 ]]
      then
         echo -e "$JAUNE Minecraft n'est toujours pas arrete. On attend encore un peu.. $NORMAL"
      fi
      if [[ $seconds -ge 120 ]]
      then
         logger -t minecraft-init "Minecraft n'a pas reussi a s'eteindre. Essayez de forcer avec kill, attention perte de donnees."
         echo -e "$ROUGE Minecraft n'a pas reussi a s'eteindre. Essayez de forcer avec kill, attention perte de donnees. $NORMAL"
         exit 1
      fi
   done   
   echo -e "$VERT Minecraft s'est arrete. $NORMAL"
}

get_worlds() {
   a=1
   for NAME in $(ls $WORLDSTORAGE)
   do
      if [ -d $WORLDSTORAGE/$NAME ]
      then
	 if [ -d $WORLDSTORAGE/$NAME/data ]
	 then
             WORLDNAME[$a]=$NAME
             a=$a+1
	 fi
      fi
   done
}

mc_whole_backup() {
   echo -e "$JAUNE Sauvegarde du serveur entier dans $WHOLEBACKUP $NORMAL"
   as_user "mkdir -p $WHOLEBACKUP"
   path=`datepath $WHOLEBACKUP/minecraft_`
   as_user "cp -rP $MCPATH $path"
}

mc_world_backup() {
   #
   # Backup the worlds and puts them in a folder for each day (unless $BACKUPSCRIPTCOMPATIBLE is set)
   #

   get_worlds
   today="`date +%F`"
   as_user "mkdir -p $WORLBACKUPPATH"
   # Check if the backupt script compatibility is enabled
      if [ "$BACKUPSCRIPTCOMPATIBLE" ]
      then
         echo "Detected that backup script compatibility is enabled, deleting old backups that are not necessary."
         as_user "rm -r $BACKUPPATH/*"
      fi
   for INDEX in ${!WORLDNAME[@]}
   do
      echo -e "$JAUNE Sauvegarde du monde: ${WORLDNAME[$INDEX]} $NORMAL"
      case "$BACKUPFORMAT" in
         tar)
            if [ "$BACKUPSCRIPTCOMPATIBLE" ]
            # If is set tars will be put in $WORLBACKUPPATH without any timestamp to be compatible with
            # [backup rotation script](https://github.com/adamfeuer/rotate-backups)
            then
               path=$WORLBACKUPPATH/${WORLDNAME[$INDEX]}.tar.bz2
            else
               as_user "mkdir -p $WORLBACKUPPATH/${today}"
               path=`datepath $WORLBACKUPPATH/${today}/${WORLDNAME[$INDEX]}_ .tar.bz2 .tar.bz2`
            fi
            as_user "tar -hcjf $path $MCPATH/${WORLDNAME[$INDEX]}"
            ;;
         zip)
            if [ "$BACKUPSCRIPTCOMPATIBLE" ]
            then
               path=$WORLBACKUPPATH/${WORLDNAME[$INDEX]}.zip
            else
               as_user "mkdir -p $WORLBACKUPPATH/${today}"
               path=`datepath $WORLBACKUPPATH/${today}/${WORLDNAME[$INDEX]}_ .zip .zip`
            fi
            as_user "zip -rq $path $MCPATH/${WORLDNAME[$INDEX]}"
            ;;
         *)
            echo -e "$BACKUPFORMAT is no supported backup format"
            ;;
      esac
   done
}

mc_console() {
   if is_running
   then
      chmod -R 777 /dev/pts/*
      as_user "screen -r $SCREEN"
   else
      echo -e "$ROUGE Minecraft n'est pas demarre. Impossible de voir la console. $NORMAL"
   fi
}

mc_config() {
   clear
   echo "########################################################"
   echo "# Bienvenue dans le script de configuration Minecraft  #"
   echo "#                                                      #"
   echo "# C'est ici que vous allez pouvoir modifer rapidement  #"
   echo "# les différents paramètres de votre serveur Minecft #"
   echo "#                                                      #"
   echo "# Si vous ne savez pas quoi entrer, appuyez simplement #"
   echo "# sur la touche Entrer de votre clavier pour continuer #"
   echo "########################################################"
   echo ""
   SC_PATH=$(readlink -f $0)

   # Ask for Maximum RAM
   read -e -p "Memoire vive maximum en pourcent : " -i "$RAM" P_XMX

   TEST_PERCENT=`echo "$P_XMX" | grep '^[0-9]\{2,2\}$'`;
   if [ -z "$TEST_PERCENT" ]; then
      echo -e "$ROUGE Erreur -> Le pourcentage n'est pas compris entre 10..99 : '" $1"' $NORMAL";
      exit 1;
   fi
   sed -i "s/^RAM=\".*/RAM=\"${P_XMX}\"/" $SC_PATH

   # Ask for server mv
   read -e -p "Voulez vous deplacer le serveur Minecraft (cas de multi-serveurs) ? " -i "Non" Q_MV
   if echo $Q_MV | grep -i "^oui$" > /dev/null ; then
	read -e -p "Nom du serveur (5 lettres et plus, unique et sans espace!) : " -i "$SCREEN" Q_SCREEN
	read -e -p "Emplacement du serveur : " -i "$MCPATH" Q_MCPATH
	read -e -p "Emplacement des sauvegardes du serveur : " -i "$BACKUPPATH" Q_BACKUPPATH
	if [ ${#Q_SCREEN} -le 5 ] || [ ${#Q_MCPATH} -le 3 ] || [ ${#Q_BACKUPPATH} -le 5 ]; then
	   echo -e "${ROUGE} Les chaines sont trop courtes ! $NORMAL";
	   exit 1
	fi
	Q_MCPATH="$(echo $Q_MCPATH | sed 's/\//\\\//g')"
	Q_BACKUPPATH="$(echo $Q_BACKUPPATH | sed 's/\//\\\//g')"
	sed -i "s/^SCREEN=\".*/SCREEN=\"${Q_SCREEN}\"/" $SC_PATH
	sed -i "s/^MCPATH=\".*/MCPATH=\"${Q_MCPATH}\/\"/" $SC_PATH
	sed -i "s/^BACKUPPATH=\".*/BACKUPPATH=\"${Q_BACKUPPATH}\/\"/" $SC_PATH
	mkdir -p $Q_MCPATH 2> /dev/nul
	mkdir -p $Q_BACKUPPATH 2> /dev/null
   fi

   # Good bye
   echo -e "${VERT}Configuration terminee.$NORMAL Vous devriez redemarrer votre serveur."
}

case "$1" in
   start)
      # Starts the server
      if is_running; then
         echo -e "$JAUNE Le serveur est deja demarre. $NORMAL"
      else
         mc_start
      fi
      ;;
   stop)
      # Stops the server
      if is_running; then
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say --------------------------------------  \"\015'"
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say Arret du serveur dans 10 secondes     \"\015'"
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say --------------------------------------  \"\015'"
         mc_stop
      else
         echo -e "$ROUGE Pas de serveur demarre $NORMAL"
      fi
      ;;
   restart)
      # Restarts the server
      if is_running; then
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say -------------------------------------- \"\015'"
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say Redémarage du serveur dans 10 secondes \"\015'"
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say -------------------------------------- \"\015'"
         mc_stop
      else
         echo -e "$ROUGE Le serveur n'est pas demarre. $VERT Demarrage... $NORMAL"
      fi
      mc_start
      ;;
   backup)
      # Backups world
      if is_running; then
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say -------------------------------------- \"\015'"
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say Sauvegarde des mondes.\"\015'"
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say -------------------------------------- \"\015'"
         mc_saveoff
         mc_world_backup
         mc_saveon
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say -------------------------------------- \"\015'"
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say Sauvegarde termine.\"\015'"
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say -------------------------------------- \"\015'"
      else
         mc_world_backup
      fi
      ;;
   whole-backup)
                # Backup everything
      if is_running; then
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say -------------------------------------- \"\015'"
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say Sauvegarde du serveur entier ...... \"\015'"
         as_user "screen -p 0 -S $SCREEN -X eval 'stuff \"say -------------------------------------- \"\015'"
         mc_stop
         mc_whole_backup
         mc_start
      else
         mc_whole_backup
      fi
      ;;
   save-off)
      # Flushes the state of the world to disk, and then disables
      # saving until save-on is called (useful if you have your own
      # backup scripts).
      if is_running; then
         mc_saveoff
      else
         echo -e "$VERT Le serveur n etait pas demarre. Sync depuis la ram quand meme... $NORMAL"
      fi
      ;;
   save-on)
      # Re-enables saving if it was disabled by save-off.
      if is_running; then
         mc_saveon
      else
         echo -e "$ROUGE Le serveur n'est pas demarre. $NORMAL"
      fi
      ;;
   command)
      # launch a command ingame
      if is_running; then
         mc_command "$2"
      else
         echo -e "$ROUGE Le serveur n'est pas demarre. Impossible de faire cela $NORMAL"
      fi
      ;;
   status)
      # Shows server status
      if is_running
      then
         echo -e "$VERT Minecraft est demarre. $NORMAL"
      else
         echo -e "$ROUGE Minecraft n'est pas demarre. $NORMAL"
      fi
      ;;
   kill)
	   PID=`ps aux | grep -v grep | grep $SCREEN | awk '{print $2}'`
	   kill -9 ${PID[0]} 2>/dev/null
   	;;
   console)
      if is_running; then
         mc_console
      else
         echo -e "$ROUGE Le serveur n'est pas demarre. $NORMAL"
      fi
      ;;
   config)
      mc_config
      ;;
   *)
echo -e "$ROSE [HarmonyScript - Minecraft - V1.0]"
echo
echo -e "$ROSE Commandes :"
echo -e "$VERT start $CYAN == $JAUNE Demarre le serveur"
echo -e "$NORMAL EX: service minecraft start"

echo -e "$VERT stop $CYAN == $JAUNE Arrete le serveur"
echo -e "$NORMAL EX: service minecraft stop"

echo -e "$VERT restart $CYAN == $JAUNE Redemarre le serveur"
echo -e "$NORMAL EX: service minecraft restart"

echo -e "$VERT console $CYAN == $JAUNE Affiche la console minecraft"
echo -e "$NORMAL EX: service minecraft console"

echo -e "$VERT backup $CYAN == $JAUNE Backup les mondes du serveur"
echo -e "$NORMAL EX: service minecraft backup"

echo -e "$VERT whole-backup $CYAN == $JAUNE Backup le serveur dans son ensemble"
echo -e "$NORMAL EX: service minecraft whole-backup"

echo -e "$VERT command $CYAN == $JAUNE Lance une commande dans le jeu"
echo -e "$NORMAL EX: service minecraft command \"say hello\" "

echo -e "$VERT status $CYAN == $JAUNE Affiche le status du serveur"
echo -e "$NORMAL EX: service minecraft status"

echo -e "$VERT kill $CYAN == $JAUNE Ferme $ROUGE brusquement $JAUNE Minecraft $ROUGE ATTENTION !!"
echo -e "$VERT$ROUGE ATTENTION CETTE COMMANDE ENTRAINE UN ROLLBACK DU SERVEUR !! PAS DE SAUVEGARDE EFFECTUEE !!"
echo -e "$NORMAL EX: service minecraft kill $NORMAL"

echo -e "$VERT config $CYAN == $JAUNE Configure la memoire vive du serveur et son emplacement"
echo -e "$NORMAL EX: service minecraft config"
      ;;
esac

exit 0

