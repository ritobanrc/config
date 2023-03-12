#!/bin/bash

FILE=$HOME/config/gnome/settings.ini

dconf dump / > $FILE
nvim $FILE
dconf load -f / < $FILE

