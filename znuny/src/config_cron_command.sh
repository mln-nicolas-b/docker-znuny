CRONS_PATH="/opt/otrs/var/cron"

customLogger "info" "config_cron" "Create crons"
for CRON in $(${CRONS_PATH}/*.dist); do
  cp ${CRON} $(basename $foo .dist)
done
