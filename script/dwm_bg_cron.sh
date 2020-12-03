#!/bin/bash
#更改壁纸
#实际是向Bg管道发送指令，权限得注意一下，
echo "/usr/bin/feh --randomize --bg-fill ~/software/dwm/img/" > ~/software/dwm/script/Bg;
echo "[$(date)] >CRON< RESET blackgorund " >> ~/software/dwm/script/dwm_status.log;
