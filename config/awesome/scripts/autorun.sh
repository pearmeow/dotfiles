#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

# function doesn't work with this arg
steam -system-composer
run "brave"
run "vesktop"
