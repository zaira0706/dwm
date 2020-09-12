#!/bin/bash

get_power_status() {		#查看电池充放状态
	if $(acpi -b | grep --quiet Discharging)
	then
		echo "-";	#电池放电
	else
		echo "+";	#电池充电
	fi
}

get_power_dumpEnergy() {	#查看剩余电量
	echo "$(cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/PNP0C0A:00/power_supply/BAT1/capacity)%";
}

get_power() {	#电量状态结合	
	echo "$(get_power_status)$(get_power_dumpEnergy)";
}

get_netCard_Ip() {		#查看联网ip
	echo "$(ip route get 8.8.8.8 2>/dev/null | awk '{printf $5}') <- $(ip route get 8.8.8.8 2>/dev/null | awk '{print $3}')";
}

dwm_alsa () {	#音量
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
        if [ "$VOL" -eq 0 ]; then
            printf "MUTE"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "VOL %s%%" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf "VOL %s%%" "$VOL"
        else
            printf "VOL %s%%" "$VOL"
        fi
}


xsetroot -name "[$(dwm_alsa)] [NET:$(get_netCard_Ip)] [POWER:$(get_power)] >_<";
echo "[$(date)] manual SET dwm std status " >> ~/software/dwm/script/dwm_status.log;
