## 慢查询日志切割脚本，在当前慢查询日志中保留上周一之后的内容，之前的内容生成以日期结尾的历史文件。


basedir="/usr/local/mysql/"
#
filename="/data/mysql/data/slow.log"


date=`grep -m 1 "^# Time:" ${filename}`
split_text_index=`expr index "$date" -`
if [ ${split_text_index} -eq 0 ]
then
	date_type="%y%m%d"
else
	date_type="%Y-%m-%d"
fi

today=`date +%Y%m%d`
lastday=`date  -d "7 days ago" +%Y%m%d`
weekoftoday=`date +%w`
day_interval=$[6 + ${weekoftoday}]
while [ $day_interval -ge 0 ]
do
	last_monday=`date -d "${day_interval} days ago" +${date_type}`
	linetext=`grep -m 1 -n "^# Time: ${last_monday}" $filename`	
	if [ -n "${linetext}" ]
	then
		line=${linetext%%:*}
		line=$[line -1] 
		if [ $line -gt 0 ]
		then
			head -n ${line} ${filename} >${filename}-${today}
			sed -i "1,${line}d" ${filename}
      # 刷新日志 5.6去掉slow
			${basedir}bin/mysqladmin --login-path=rotate flush-logs slow				   
		fi
		dir=${filename%/*}
		name=${filename##*/}
		find $dir -name $name-$lastday -exec rm -f {} \;
		break
	else			
		day_interval=$[day_interval - 1]
	fi
done
