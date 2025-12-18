#!/bin/bash
VIDEO_LOCATION=~/Video\'s

gsettings set org.gnome.shell favorite-apps "['firefox-esr.desktop', 'org.gnome.Evolution.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'org.gnome.TextEditor.desktop', 'org.gnome.Calculator.desktop', 'yelp.desktop']"
gsettings set org.gnome.desktop.interface cursor-size 96
gsettings set org.gnome.desktop.interface text-scaling-factor 2
screenkey &
DATE_NOW=$(date +%Y-%m-%d-%H%M)
OUTFILE=$VIDEO_LOCATION/screenrecording-$DATE_NOW.ogv
recordmydesktop --no-sound --display :0 --width 3840 --height 2160 -o $OUTFILE  &> $VIDEO_LOCATION/recording-$DATE_NOW.log
notify-send --app-name recordmydesktop "Finished" "Finished recording $OUTFILE"

