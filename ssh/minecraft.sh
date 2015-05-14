#!/bin/bash
#Création par unixfox (Emilien)
#Merci Julien008 pour les suggestions et report de bugs.

#Options
MC_PATH=''
NOM_JAR=''
MEMALOC=512
TPSWARN=10
SCREEN_NAME=''

is_running() {
   if ps ax | grep -v grep | grep "$SCREEN_NAME" > /dev/null
   then
      return 0
   fi
   return 1
}

#Variables
server_stop() {
        echo -n "Arrêt du serveur Minecraft..."
        screen -S $SCREEN_NAME -p 0 -X stuff "`printf "say Arrêt du serveur dans $TPSWARN SECONDES.\r"`"
        screen -S $SCREEN_NAME -p 0 -X stuff "`printf "save-all\r"`"
        sleep ${TPSWARN}
        screen -S $SCREEN_NAME -p 0 -X stuff "`printf "stop\r"`"
        sleep 7
        echo " [OK]"
}

server_start() {
        echo -n "Lancement du serveur minecraft..."
        cd $MC_PATH && screen -h 1024 -dmS $SCREEN_NAME java -jar -Xmx${MEMALOC}M -Xms512M -XX:MaxPermSize=128M -Dfile.encoding=UTF8 $NOM_JAR nogui; 
        sleep 1
        echo " [OK]"
}

commande() {
     exec="$1";
     echo "Exécution de la commande..."
     screen -S $SCREEN_NAME -p 0 -X stuff "`printf "$exec\r"`"
     sleep .1
     echo " [OK]"
}

console() {
     screen -r $SCREEN_NAME
}

# Corps du script
case "$1" in
  start)
      # Starts the server
      if is_running; then
         echo "Le serveur est deja demarre."
      else
         mc_start
      fi
      ;;
  stop)
      # Stops the server
      if is_running; then
         server_stop
      else
         echo "Pas de serveur demarre"
      fi
      ;;
  restart)
    server_stop
    server_start
    ;;
  exec)
        if [ $# -gt 1 ]; then
        shift
        commande "$*"
        else
        echo "Vous devez spécifier une commande (exemple : 'help')."
  fi
  ;;
  console)
    console
    ;;
  *)
        echo "Utilisation: service minecraft {start|stop|exec <commande>|console}"
        exit 0
        ;;
esac

exit 0
