#!/usr/bin/env python
# coding: utf-8

# 创建人：月饮沙
# 说明：从mysql数据库中获取使用pt-query-digest分析的慢查询结果

import pymysql
import xlsxwriter
host = '192.168.0.1'
port = 3306
user = 'slowlog'
password = 'slowlog'
database = 'slowlog_report'

filename = "./slowlog.xlsx"

dbinfo = {
    'host': host,
    'port': port,
    'user': user,
    'passwd': password,
    'db': database
}
conn = pymysql.connect(**dbinfo)
cursor = conn.cursor()
get_table_sql = "select table_name from information_schema.tables where table_schema='" + database + "';"
cursor.execute(get_table_sql)
table_list = cursor.fetchall()

cursor.close()

result = []
cur = pymysql.cursors.DictCursor(conn)
for i in table_list:
    sql = "select * from `" + i[0] + "`"
    cur.execute(sql)
    res = cur.fetchall()
    for j in res:
        j["file"] = i[0]
    result = result + list(res)

cur.close()
conn.close()


workbook = xlsxwriter.Workbook(filename)
worksheet = workbook.add_worksheet()

row = 0
col = 0
for i in list(result[0].keys()):
    worksheet.write_string(row, col, i)
    col = col + 1
row = row + 1
for i in result:
    col = 0
    for j in list(i.values()):
        j = str(j)
        worksheet.write_string(row, col, j)
        col = col + 1
    row = row + 1

workbook.close()
