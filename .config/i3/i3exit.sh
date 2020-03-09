#!/usr/bin/env bash

lock() {
  IMAGE=/tmp/i3lock.png
  SCREENSHOT="maim $IMAGE" # 0.46s
  BLURTYPE="0x5" # 7.52s
  $SCREENSHOT
  convert $IMAGE -blur $BLURTYPE $IMAGE
  i3lock -i $IMAGE
  rm $IMAGE
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        lock && systemctl suspend
        ;;
    hibernate)
        lock && systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 [lock|logout|suspend|hibernate|reboot|shutdown]"
        exit 2
esac

exit 0
