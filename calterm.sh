#!/bin/bash
pkill -9 -f 'urx.*calterm.*'
/usr/bin/urxvt -name calterm -title top -tn calterm&
