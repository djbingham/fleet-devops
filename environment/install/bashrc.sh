#! /usr/bin/bash

# Overwrite .bashrc symlink with a copy of the .bashrc, so we can extend it.
cp /usr/share/skel/.bashrc /home/core/.bashrc.new
mv /home/core/.bashrc.new /home/core/.bashrc
