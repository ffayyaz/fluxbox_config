#!/bin/bash
if [ "`whoami`" = "root" ]; then
    aptitude install `grep -v ^# pkgs_to_install |tr '\n' ' '`
fi
