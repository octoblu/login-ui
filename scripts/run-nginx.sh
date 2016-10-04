#!/bin/bash

write_config() {
  local template_file="$1"
  cp "/templates/${template_file}" /etc/nginx/conf.d/default.conf
}

write_default_config() {
  if [ "$BUNDLED_ASSETS" == "true" ]; then
    echo 'using bundled-default.conf'
    write_config 'bundled-default.conf'
  else
    echo 'using default.conf'
    write_config 'default.conf'
  fi
}

copy_config() {
  echo 'copying gzip.conf'
  cp /templates/gzip.conf /etc/nginx/conf.d/gzip.conf
}

start_nginx() {
  if [ "$DEBUG" == 'nginx' ]; then
    echo 'starting in debug mode'
    nginx-debug -g 'daemon off;'
  else
    echo 'starting normally'
    nginx -g 'daemon off;'
  fi
}

main() {
  write_default_config && \
    copy_config && \
    start_nginx
}

main "$@"
