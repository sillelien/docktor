#!/usr/bin/env bash

set -e


export PATH=$PATH:/scripts/checks:/scripts/fixes

while true
do
    env_vars=$(env | grep ".*_NAME=" | cut -d= -f1 | tr '\n' ' ')

    [ ! -f /tmp/cron.tmp ] || rm /tmp/cron.tmp

    for env_var in $env_vars
    do
      # Set on the remote service
      check_env_var=${env_var%_NAME}_ENV_CHECK_COMMAND
      fix_env_var=${env_var%_NAME}_ENV_FIX_COMMAND
      #  Set on the cron service
      check_var=${env_var%_NAME}_CHECK_COMMAND
      fix_var=${env_var%_NAME}_FIX_COMMAND

      if [[ -n ${!check_var} ]]
      then
        check="${!check_var}"
      else
        check="${!check_env_var}"
      fi

      if [[ -n ${!fix_var} ]]
      then
        fix="${!fix_var}"
      else
        fix="${!fix_env_var}"
      fi

      service_name=${env_var}

      export check service_name
      if bash -cex "$check"
      then
        echo "CHECK PASSED"
        sleep ${CHECK_INTERVAL:-60}
      else
      echo "CHECK FAILED"
        if bash -cex "$fix"
        then
            echo "FIX RAN OKAY"
            sleep ${CHECK_INTERVAL:-60}
        else
            echo "FIX FAILED"
            sleep ${RECHECK_INTERVAL:-${CHECK_INTERVAL}}
        fi
      fi

    done
done
  
