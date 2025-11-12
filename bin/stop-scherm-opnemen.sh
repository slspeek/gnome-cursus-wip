#!/bin/bash

pkill -SIGINT recordmydesktop
pkill screenkey
normal-scale.sh
gsettings set org.gnome.shell favorite-apps "['firefox-esr.desktop', 'code.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'org.gnome.TextEditor.desktop', 'org.gnome.Calculator.desktop', 'yelp.desktop']"
gsettings set org.gnome.desktop.interface cursor-size 32
