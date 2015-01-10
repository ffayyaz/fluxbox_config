#!/bin/bash
if [ "`whoami`" = "root" ]; then
    aptitude install `grep -v ^# /home/fafa/.fluxbox/pkgs_to_install |tr '\n' ' '`
fi
