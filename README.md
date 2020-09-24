一些工作中用到的脚本

## SHELL脚本
* `change_loop_dir_file_to_dir.sh`
将一个文件夹中所有子目录中的文件移动到另一个文件夹中，可以配合`ansible fetch`模块使用，获取多个数据库的慢查询日志文件

* `mysql_slow_log_report.sh`
对一个文件夹中的所有MySQL慢查询日志文件进行分析

## Python脚本
* `get_slow_info_from_mysql_to_excel.py`
将保存到数据库中的所有利用`pt-query-digest`分析的慢查询日志结果合并到一个Excel文件中
