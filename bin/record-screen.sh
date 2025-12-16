#!/bin/bash

OUTFILE=$HOME/screenrecording-$(date +%Y-%m-%d-%H%m).ogv
recordmydesktop --no-sound --display :0 --width 3840 --height 2160 -o $OUTFILE  &> $HOME/recording.log
notify-send Finished recording $OUTFILE
