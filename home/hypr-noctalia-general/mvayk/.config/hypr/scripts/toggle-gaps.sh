#!/usr/bin/env bash

GAPS_OUT=$(hyprctl getoption general:gaps_out | grep "int:" | awk '{print $2}')

if [ "$GAPS_OUT" -eq 0 ]; then
    hyprctl keyword general:gaps_out 8
    hyprctl keyword general:gaps_in 2
else
    hyprctl keyword general:gaps_out 0
    hyprctl keyword general:gaps_in 0
fi
