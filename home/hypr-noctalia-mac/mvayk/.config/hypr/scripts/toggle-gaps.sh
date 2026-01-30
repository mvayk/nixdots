#!/usr/bin/env bash

ROUNDING=$(hyprctl getoption decoration:rounding | grep "int:" | awk '{print $2}')

if [ "$ROUNDING" -eq 0 ]; then
    hyprctl keyword general:gaps_out 8
    hyprctl keyword general:gaps_in 2
    hyprctl keyword decoration:rounding 20
    hyprctl keyword decoration:rounding_power 2
else
    hyprctl keyword general:gaps_out 0
    hyprctl keyword general:gaps_in 0
    hyprctl keyword decoration:rounding 0
    hyprctl keyword decoration:rounding_power 1
fi
