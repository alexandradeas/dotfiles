#!/bin/sh
set -e
i3lock --nofork --show-failed-attempts --ignore-empty-password --fill --image="${HOME}/dotfiles/evening-sky.png"
xset dpms
