#!/bin/bash

#通过实名管道显示进程间通信，让crontab定时脚本输出到dwm接收
#这是在dwm进程中执行的 只要管道'status'中有数据，马上读取出来，并设置到状态栏
while true;
do
	xsetroot -name "`cat < ~/software/dwm/script/status`";
done 
