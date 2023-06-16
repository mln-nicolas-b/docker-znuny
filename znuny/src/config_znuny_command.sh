CONFIG_PATH="/opt/otrs/Kernel/Config.pm"

set_env

customLogger "info" "config_znuny" "Check if the config file already exists"
if [[ -f "${CONFIG_PATH}" ]]; then
  customLogger "warn" "config_znuny" "The configuration file of Znuny already exists and will be replaced"
  rm ${CONFIG_PATH}
fi

customLogger "info" "config_znuny" "Create the configuration of Znuny"
touch ${CONFIG_PATH}

customLogger "info" "config_znuny" "Generate the licence"
gen_add_licence

customLogger "info" "config_znuny" "Generate packages"
gen_add_package

customLogger "info" "config_znuny" "Generate uses"
gen_add_use

customLogger "info" "config_znuny" "Generate sub"
gen_add_sub

customLogger "info" "config_znuny" "Generate database connection"
gen_add_database_credentials "${ZNUNY_DATABASE_HOST}" "${ZNUNY_DATABASE_NAME}" "${ZNUNY_DATABASE_USER}" "${ZNUNY_DATABASE_PASSWORD}"

customLogger "info" "config_znuny" "Generate the database driver"
case ${ZNUNY_DATABASE_TYPE} in
  "mysql")
    gen_add_database_mysql
    ;;
  "pgsql")
    gen_add_database_postgresql
    ;;
  "mssql")
    gen_add_database_microsoftsql
    ;;
  "oracle")
    gen_add_database_oracle
    ;;
esac

customLogger "info" "config_znuny" "Generate the filesystem root directory"
gen_add_fs_root_dir

customLogger "info" "config_znuny" "Generate the configuration return"
gen_add_return

customLogger "info" "config_znuny" "Generate the system stuffs"
gen_add_system_stuff

customLogger "info" "config_znuny" "End file"
gen_add_end