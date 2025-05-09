#!/bin/bash
CONTEST_ID=1977		# 比赛编号
DATA_DIR="contest_${CONTEST_ID}"	# 数据存放目录

# 创建比赛目录
mkdir -p ${DATA_DIR}

# 下载比赛元数据
echo "正在下载比赛${CONTEST_ID}信息..."
curl -s "https://codeforces.com/api/contest.standings?contestId=${CONTEST_ID}&from=1&count=5" > ${DATA_DIR}/contest.json

# 检查是否下载成功
if [ ! -s ${DATA_DIR}/contest.json ]; then
	echo "错误：无法获取比赛数据，请检查网络或比赛编号"
	exit 1
fi

# 根据题目编号（A, B, C...）
PROBLEM_IDS=$(jq -r '.result.problems[].index' ${DATA_DIR}/contest.json)
echo "检测到题目编号： " ${PROBLEM_IDS}

# 下载每个题目的测试数据
for PROBLEM_ID in ${PROBLEM_IDS}; do
	echo "正在下载题目${PROBLEM_ID}的测试数据..."
	mkdir -p ${DATA_DIR}/${PROBLEM_ID}
	wget -q -O ${DATA_DIR}/${PROBLEM_ID}/tests.zip "http://codeforces.com/contest/${CONTEST_ID}
	/problem/${PROBLEM_ID}/tests"
	unzip -oq ${DATA_DIR}/${PROBLEM_ID}/tests.zip -d ${DATA_DIR}/${PROBLEM_ID}/
	rm ${DATA_DIR}/${PROBLEM_ID}/tests.zip
done

echo "数据下载完成！存放路径: $(pwd)/${DATA_DIR}"
