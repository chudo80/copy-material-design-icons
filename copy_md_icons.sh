#!/bin/bash
# By Chudo Cheung <chudo_cheung@163.com>
# https://github.com/chudo-cheung/copy-material-design-icons/
#
# Material Design Icons 项目是 Google 根据 Material Design 准则设计的官方图标集
# 主页：https://github.com/google/material-design-icons
# git: https://github.com/google/material-design-icons.git
#
# 使用方法：
# 1. 下载 Material design icons 项目到本地；
# 2. 修改下面的 MDI_PROJ_DIR 变量的值，填入 Material Design Icons 项目的目录；
# 3. 假设想使用 ic_arrow_back_black_26dp.png 这种图案，图标大小 48dp，白色，输入以下命令即可：
#       ./copy_md_icons.sh 这里填入App项目的目录 arrow_back 48 white
#
# 图标大小(共提供四种)：
#   18dp
#   24dp
#   36dp
#   48dp
#
# 图标颜色(共提供两种)：
#   white
#   black

# Material Design Icons 项目的目录 (**请自行修改**)
MDI_PROJ_DIR="/code/material-design-icons/"

PROG_NAME="$0"

help() {
    echo "参数有误！" >&2
    echo >&2
    echo "用法: $PROG_NAME <APP 项目目录> <图标名称> <大小> [颜色]" >&2
    echo "    大小：单位 dp，可选值 18、24、36、48" >&2
    echo "    颜色：可选值 black (如果省略默认)、white" >&2
    echo >&2
    exit
}


app_proj_dir="$1"
name="`echo "$2" | sed 's/^ic_//; s/^_//; s/\(_18dp\|_24dp\|_36dp\|_48dp\|_black\|_white\|.png\)//g; s/_$//'`"

if [ "$#" -lt 3 -o ! -d "$app_proj_dir" -o -z "$name" ]; then
    help
fi

case "$3" in
    18 | 24 | 36 | 48) size="$3" ;;
    *) help ;;
esac

case "$4" in
    white) color="white" ;;
    black | "") color="black" ;;
    *) help ;;
esac

for dentify in mdpi hdpi xhdpi xxhdpi xxxhdpi; do
    dst_dir="$app_proj_dir/app/src/main/res/drawable-$dentify/"
    mkdir -p "$dst_dir"
    cp -v "$MDI_PROJ_DIR/"*"/drawable-$dentify/ic_${name}_${color}_${size%dp}dp.png" "$dst_dir"
done
