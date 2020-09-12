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
	echo "$(ip route get 8.8.8.8 2>/dev/null | awk '{printf $5}') <- $(ip route get 8.8.8.8 2>/dev/null | awk '{print $3}')";
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
#搞个log方便查看哪有问题，
echo "[$(date)] >CRON< AUTO SET Starting" >> ~/software/dwm/script/dwm_status.log;

PROC_NAME="xinit";		#存在xinit进程才可
ProcNumber=`ps -ef | grep -w $PROC_NAME | grep -v grep | wc -l`;
if [ $ProcNumber -eq 0 ]
then
	echo "[$(date)] xinit not run,so nothing script need runing" >> ~/software/dwm/script/dwm_status.log;
else
	echo "[$(date)] cache xinit runing OK!,next cache dwm proc" >> ~/software/dwm/script/dwm_status.log;
	PROC_NAME="dwm";	#确定开启了dwm才可
	ProcNumber=`ps -ef | grep -w $PROC_NAME | grep -v grep | wc -l`;
	if [ $ProcNumber -eq 0 ]
	then
		echo "[$(date)] dwm not run,so nothing script need runing" >> ~/software/dwm/script/dwm_status.log;
	else
		echo "[$(date)] cache dwm runing OK!,next SET dwm status" >> ~/software/dwm/script/dwm_status.log;
		I=1;
		while [ $I -le 30 ]
		do
			echo "[TIME:$(date)] :)" > ~/software/dwm/script/status;
			sleep 1;
			I=`expr $I + 1`;
		done
		echo "[$(date)] >CRON< AUTO SET dwm status TIME " >> ~/software/dwm/script/dwm_status.log;

	echo "[$(dwm_alsa)] [NET:$(get_netCard_Ip)] [POWER:$(get_power)] O.O" > ~/software/dwm/script/status;
	echo "[$(date)] >CRON< AUTO SET dwm std status " >> ~/software/dwm/script/dwm_status.log;
	fi
fi
echo "[$(date)] >CRON< AUTO SET OK" >> ~/software/dwm/script/dwm_status.log;
