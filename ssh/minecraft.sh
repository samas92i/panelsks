#!/bin/bash
#Création par unixfox (Emilien)
#Merci Julien008 pour les suggestions et report de bugs.

#Options
MC_PATH=''
NOM_JAR=''
MEMALOC=512
TPSWARN=10
SCREEN_NAME=''

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
        server_start
        ;;
  stop)
        server_stop
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
