#!/bin/bash
if [ "`whoami`" = "root" ]; then
    grep -v '^#' /home/fafa/.fluxbox/pkgs_to_install|while read PKG; do
        echo -ne "$PKG: "
        dpkg -l|awk '/^ii/ {print $2}'|grep -q "^${PKG}$" && echo "${PKG} already installed" || apt-get install -y ${PKG}
        echo ""
    done
fi
