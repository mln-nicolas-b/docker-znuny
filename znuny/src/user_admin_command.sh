customLogger "info" "user_admin" "Create the application admin user: '${ZNUNY_USER_ADMIN_NAME}'"
su -c "/opt/otrs/bin/otrs.Console.pl Admin::User::SetPassword ${ZNUNY_USER_ADMIN_NAME} ${ZNUNY_USER_ADMIN_PASSWORD}" -s /bin/sh otrs 2>&1 |\
  while true; do
    if IFS= read -r MESSAGE; then
      if [[ -n "${MESSAGE}" ]]; then
        echo -e "{\"timestamp\":\"$(date +'%Y-%m-%d %H:%M:%S')\", \"level\":\"info\", \"source\":\"znuny\", \"message\":\"${MESSAGE}\"}"
      fi
    fi
  done &