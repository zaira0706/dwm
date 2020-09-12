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

get_netCard_Ip() {
	echo "$(ip route get 202.103.24.68 2>/dev/null | awk '{printf $5}') <- $(ip route get 202.103.24.68 2>/dev/null | awk '{print $3}')";
}

dwm_alsa () {
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

#PROC_NAME="xinit";
#ProcNumber=`ps -ef | grep -w $PROC_NAME | grep -v grep | wc -l`;
#if [ $ProcNumber -eq 0 ]
#then
#	echo "[$(date)] xinit not run,so nothing script need runing" >> ~/software/dwm/script/dwm_status.log;
#else
#	echo "[$(date)] cache xinit runing OK!,next cache dwm proc" >> ~/software/dwm/script/dwm_status.log;
#	PROC_NAME="dwm";
#	ProcNumber=`ps -ef | grep -w $PROC_NAME | grep -v grep | wc -l`;
#	if [ $ProcNumber -eq 0 ]
#	then
#		echo "[$(date)] dwm not run,so nothing script need runing" >> ~/software/dwm/script/dwm_status.log;
#	else
#		echo "[$(date)] cache dwm runing OK!,next SET dwm status" >> ~/software/dwm/script/dwm_status.log;
#while true;do
		I=1;
		while [ $I -le 30 ]
		do
			xsetroot -name "[TIME:$(date)] :)";
			sleep 1;
			I=`expr $I + 1`;
		done
		echo "[$(date)]AUTO SET dwm status TIME " >> ~/software/dwm/script/dwm_status.log;

#	fi
	xsetroot -name "[$(dwm_alsa)] [NET:$(get_netCard_Ip)] [POWER:$(get_power)] O.O";
	echo "[$(date)]AUTO SET dwm std status " >> ~/software/dwm/script/dwm_status.log;
#done &
#fi &
