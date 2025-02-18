#!/bin/bash

# Check if pavucontrol is running
if pgrep -x "pavucontrol" > /dev/null
then
    # If running, kill the process
    pkill -x "pavucontrol"
else
    # If not running, start pavucontrol
    pavucontrol &
fi

