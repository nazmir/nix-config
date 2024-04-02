#!/bin/bash

app_id=$(swaymsg -t get_tree | jq -r '..|try select(.focused == true) .app_id')
#swayr switch-to-matching-or-urgent-or-lru-window "[app_name=\"$app_id\"]"
swayr next-matching-window "[app_name=\"$app_id\"]"
