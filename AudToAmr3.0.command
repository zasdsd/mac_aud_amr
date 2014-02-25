#!/bin/sh
#作者:周子元，郑梦佳
# QQ:303288057
# weibo:  weibo.com/widefire
this_dir=`pwd`
dirname $0|grep "^/" >/dev/null
if [ $? -eq 0 ];then
this_dir=`dirname $0`
else
dirname $0|grep "^\." >/dev/null    # 判断是不是直接以绝对路径进行运行的，如果是就直接取出来就行了，不需要特别处理
retval=$?
if [ $retval -eq 0 ];then           # 以 ./xxx 方式运行的脚本，去掉开头的点，并在开头加上路径
this_dir=`dirname $0|sed "s#^.#$this_dir#"`
else                                # 以 dirxxx/dirxxx/shfile 方式运行的脚本，在开头加上路径以及一个斜线
this_dir=`dirname $0|sed "s#^#$this_dir/#"`
fi
fi
#echo $this_dir
if [ ! -d $this_dir/amr/ ]
then
mkdir $this_dir/amr/
fi
for file in $this_dir/*
do
if test -f $file
then
if [ $(echo $file | egrep '.aud$') ]
then
pathString=${file##*/}
fileName=${pathString%.*}
cat $this_dir/head.txt $file > ${file%.*}.amr
mv ${file%.*}.amr  $this_dir/amr/${fileName}.amr
echo ${fileName} ok
fi
fi
done