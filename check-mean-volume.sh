#!/bin/bash

# 使い方：./check-mean-volume.sh /path/to/your/video.mp4
# 対象となる動画ファイルのパス
file_path="$1"

# 平均音量を測定
mean_volume=$(ffmpeg -i "$file_path" -af "volumedetect" -vn -sn -dn -f null /dev/null 2>&1 | grep "mean_volume" | awk -F: '{print $2}' | awk '{print $1}')

# 平均音量を表示
echo "The mean volume of the video is: ${mean_volume} dB"
