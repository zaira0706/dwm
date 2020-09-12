#!/bin/bash

#在dwm进程中一直接收其他进程的命令，并在dwm中调用
#可能存在安全隐患，暂时用来定时更换壁纸
while true;
do
	BGcom=`cat < ~/software/dwm/script/Bg`
	$BGcom
done
