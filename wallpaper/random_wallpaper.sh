#!/bin/bash
while true; do
    fbsetbg -f $(ls ./*.jpg|sort -R|tail -1)
    sleep 2
done
