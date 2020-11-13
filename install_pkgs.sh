#!/bin/bash
if [ "`whoami`" = "root" ]; then
    grep -v '^#' /home/fafa/.fluxbox/pkgs_to_install|while read PKG; do
        echo -ne "$PKG: "
        if dpkg -l|awk '/^ii/ {print $2}'|grep -q "^${PKG}$"; then
            echo "${PKG} already installed"
        else
             aptitude install ${PKG}
        fi
        echo ""
    done
fi
