#!/bin/bash
# Run as non-privileged user

GITHUB_RAW=https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO_NAME/main

GITHUB_RELEASES=https://github.com/$GITHUB_USER/$GITHUB_REPO_NAME/releases/latest/download

cd ~/Downloads
wget $GITHUB_RAW/resources/bloemen.zip 
wget $GITHUB_RELEASES/gnome-cursus.zip

cd ~/Afbeeldingen
unzip ~/Downloads/bloemen.zip

cd ~/Documenten
unzip ~/Downloads/gnome-cursus.zip

sudo apt-get -y remove chromium
if which google-chrome; then sudo apt-get remove -y google-chrome-stable; fi
if which  discord; then sudo apt-get remove -y discord; fi
