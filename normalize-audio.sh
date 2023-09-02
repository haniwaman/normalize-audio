#!/bin/bash

target_volume=-20.0  # 目標の平均音量（dB）

for file in *.mp4; do
  # 平均音量を測定
  mean_volume=$(ffmpeg -i "$file" -af "volumedetect" -vn -sn -dn -f null /dev/null 2>&1 | grep "mean_volume" | awk -F: '{print $2}' | awk '{print $1}')

  # 音量差を計算
  volume_diff=$(echo "$target_volume - $mean_volume" | bc)

  # 音量を正規化
  ffmpeg -i "$file" -af "volume=${volume_diff}dB" "normalized_$file"
done
