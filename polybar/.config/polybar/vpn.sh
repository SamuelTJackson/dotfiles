#!/bin/bash

service="$2"

if [ -z "$service" ]; then
    echo "Usage: $0 <command> <service>"
    exit 1
fi

if [ ! "$(nmcli c show --active | grep "$service")" ]; then
    echo '%{F#000000}'
else
    echo '%{F#98971a}'
fi

enable() {
    nmcli c up "$service"
}

disable() {
    nmcli c down "$service"
}

toggle() {
    if [ ! "$(nmcli c show --active | grep "$service")" ]; then
        nmcli c up "$service"
    else
        nmcli c down "$service"
    fi
}

"$1"
