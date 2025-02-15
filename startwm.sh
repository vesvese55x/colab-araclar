#!/bin/bash

rustdesk &  
startxfce4 &  
{
    wget -O /tmp/resim.jpg https://i.ibb.co/JFWSj6Cc/resim.jpg
    for workspace in $(xfconf-query -c xfce4-desktop -l | grep "workspace.*/last-image"); do
        xfconf-query -c xfce4-desktop -p $workspace -s /tmp/resim.jpg
    done
} &  

wait
