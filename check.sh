#!/usr/bin/env bash

while true
do
    env_vars=$(env | grep ".*_NAME=" | cut -d= -f1 | tr '\n' ' ')

    [ ! -f /tmp/cron.tmp ] || rm /tmp/cron.tmp

    for env_var in $env_vars
    do
      # Set on the remote service
      check_env_var=${env_var%_NAME}_ENV_CHECK_COMMAND
      #  Set on the cron service
      check_var=${env_var%_NAME}_CHECK_COMMAND

      if [[ -n check_var ]]
      then
        check="${!check_var}"
      else
        check="${!check_env_var}"
      fi
      service_name=${!env_var}
      export check service_name
      bash -c "$check"
    done
    sleep ${CHECK_INTERVAL:-60}
done
  
