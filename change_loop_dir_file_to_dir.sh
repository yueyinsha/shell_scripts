#将指定目录中的所有文件（包括所有子目录中的文件）移动到另一个目录中
#子目录中的文件名称为目录_子目录_文件名

find /data/remote_file_dir -type f |awk 'BEGIN{dir="/data/remote_file/"}{filename=$0};{gsub(/\//,"_",$0)};{print "mv " filename " " dir$0}'|/bin/bash
rename _data_remote_file_dir_ "" /data/remote_file/*
rm -rf /data/remote_file_dir/*
ls -l /data/remote_file
