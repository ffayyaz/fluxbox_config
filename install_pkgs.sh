#!/bin/bash
if [ "`whoami`" = "root" ]; then
    grep -v '^#' /home/fafa/.fluxbox/pkgs_to_install|while read PKG; do
        dpkg -l|awk '/^ii/ {print $2}'|grep -q "^${PKG}$" && echo "${PKG} already installed" || apt-get install -y ${PKG} 2 > ${0}.errors
    done
fi
