## 创建人：月饮沙
## 说明：使用pt-query-digest对慢查询日志批量进行分析，原始日志文件保存在souce_path中，结果保存到result_path中
## 也可以将慢查询分析结果保存到数据库中

souce_path="./slowlog"
result_path="./slowlog_report"

## info for mysql
# host='192.168.0.1'
# port=3306
# user='slowlog'
# password='slowlog'
# database='slowlog_report'


date=`date -d 'today' +%Y%m%d`

filestring=`ls ${souce_path}`
filelist=($filestring)

for file in ${filelist[@]}
do
pt-query-digest --filter   ${souce_path}/${file} >> ${result_path}/${date}-${file}

## save to mysql
#pt-query-digest --filter  --no-report --create-review-table --history  h=${host},D=${database},t=${file},u=${user},p=${password},P=${port} ${souce_path}/${file} 
done

## get slowlog from mysql to excel
# python3 get_slow_info_from_mysql_to_excel.py
