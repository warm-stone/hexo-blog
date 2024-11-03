$SERVER_IP="pve.name"
$USER="root"
$COMMAND="pct start 202"

ssh ${USER}@${SERVER_IP} "${COMMAND}"