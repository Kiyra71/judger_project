#!/bin/bash
# 清理七天前的日志
LOG_DIR="/home/kiyra/judger_project/logs"
find ${LOG_DIR} -name "*.log" -mtime +7 exec rm -f {} \;
echo "${date} 日志已清理" >> ${LOG_DIR}/clean.log 
