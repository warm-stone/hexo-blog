$SERVER_IP="pve.name"
$USER="root"
$COMMAND="pct shutdown 202"

ssh ${USER}@${SERVER_IP} "${COMMAND}"