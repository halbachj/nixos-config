#!/usr/bin/env bash

op=$( echo -e "\tPoweroff\n\tReboot\n\tSuspend\nH\tHibernate\n\tLock\n\tLogout" | wofi -i --dmenu | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        hibernate)
                /home/twostone/.config/swaylock/scripts/current_bg.sh
                systemctl hibernate
                ;;
        lock)
		/home/twostone/.config/swaylock/scripts/current_bg.sh
                ;;
        logout)
                swaymsg exit
                ;;
esac
