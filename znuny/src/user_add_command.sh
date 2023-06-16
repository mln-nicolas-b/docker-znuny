APP_USER="otrs"

customLogger "info" "user" "Create the application user '${APP_USER}'"
useradd -d /opt/otrs -c 'Znuny user' -g www-data -s /bin/bash -M -N ${APP_USER}

customLogger "info" "user" "Set the permission for the user onto the applications directories"
/opt/otrs/bin/otrs.SetPermissions.pl >/dev/null 2>&1
