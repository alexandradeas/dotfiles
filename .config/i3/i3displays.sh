#!/usr/bin/env bash

primaryDisplay = eDP-1
secondaryDisplay = DP-1
ternaryDisplay = DP-2

xrandr --output $primaryDisplay --left-of $secondaryDisplay --below $ternaryDisplay
xrandr --output $primaryDisplay --mode $largeRatio

i3 workspace $ws1  output $primaryDisplay
i3 workspace $ws2  output $primaryDisplay
i3 workspace $ws3  output $primaryDisplay
i3 workspace $ws4  output $primaryDisplay
i3 workspace $ws5  output $primaryDisplay
i3 workspace $ws6  output $primaryDisplay
i3 workspace $ws7  output $primaryDisplay
i3 workspace $ws8  output $primaryDisplay
i3 workspace $ws9  output $primaryDisplay
i3 workspace $ws10 output $primaryDisplay

