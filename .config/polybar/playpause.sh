#!/bin/bash
status=""

setStatus() {
  $status = playerctl status
}

if [ "$status" = "Playing" ]
then
  echo "%{#dd49b5b5}"
elif [ "$status" = "Paused" ]
then
  echo "%{F#dd49b5b5}"
else
  echo "%{F#dd49b5b5}"
fi
