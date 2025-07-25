#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run xss-lock --transfer-sleep-lock -- i3lock -e --verif-text="" --wrong-text="" --noinput-text="" --lock-text="" --nofork
