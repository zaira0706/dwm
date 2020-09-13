# 我的dwm构建
dwm 是一个非常快速, 小巧并使用动态管理窗口的窗口管理器

dwm的官网:<a href="http://suckless.org/">suckless.org</a>,推荐使用官网的原始版本从新构建你的个性dwm。

我所使用的组合:
> 窗口管理器:[dwm](http://dwm.suckless.org/)

> 启动器:[dmenu](http://tools.suckless.org/dmenu/)

> 虚拟终端:[st](http://st.suckless.org/)

### 要求

构建 dwm 前, 你需要有 `Xlib` 头文件 In order to build dwm you need the Xlib header files.(此README参考来自：[theniceboy](https://github.com/theniceboy/dwm),如果你感兴趣可参考他的dwm构建项目)

------
### 安装
编辑 config.mk 来匹配你的本地设置 (dwm 将默认安装在 /usr/local)

之后通过以下命令安装 dwm (必须使用 root 用户):

> `make clean install`

----------

### 自定义的补丁(在dwm的官网提供了很多<a href="http://dwm.suckless.org/patches/">补丁</a>以下是我所使用的)

> [dwm-hide_vacant_tags-6.2.diff](http://dwm.suckless.org/patches/hide_vacant_tags/)

> [dwm-rotatestack-20161021-ab9571b.diff](http://dwm.suckless.org/patches/rotatestack/)

> [dwm-scratchpad-6.2.diff](http://dwm.suckless.org/patches/scratchpad/)

> [dwm_vanitygaps_myzip.diff](http://dwm.suckless.org/patches/vanitygaps/)(这个补丁我删除了很多功能，如需完整功能请点击链接到官网自行下载)


--------------

### 运行dwm
将以下行添加到 `.xinitrc` 中来通过 `startx` 启动 dwm:

`exec dwm`

如果你需要使用多显示器启动 dwm, 你需要设置屏幕变量, 以下是一个例子:

> DISPLAY=foo.bar:1 exec dwm

(这样将会启动 dwm 并显示在显示器一上)

如果你想自定义你的状态栏, 你可以在 `.xinitrc` 添加行, 以下是一个例子:

```shell
while xsetroot -name "HELLO dwm `date`"
do
	sleep 1
done &
exec dwm
```
我的`.xinitrc`文件:
```shell
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
fcitx &
#以上是设置fcitx环境变量的

exec dwm
```
关于dwm的状态栏我使用脚本设置，在`dwm.c`文件中添加的自定义函数，也可使用补丁[autostart](http://dwm.suckless.org/patches/autostart/)来实现该功能，有兴趣可以查看此项目`dwm.c`中的`Mybg`函数.

脚本中分钟及以上需周期执行的任务没有使用`sleep`和`while`函数来实现定期执行，而是采用的`crontab`:
```shell
#crontab -e
*/20 * * * * ~/software/dwm/script/dwm_bg_cron.sh &>> ~/software/dwm/script/dwm_status.log

0 */1 * * * ~/software/dwm/script/dwm_status_cron.sh &>> ~/software/dwm/script/dwm_status.log
```