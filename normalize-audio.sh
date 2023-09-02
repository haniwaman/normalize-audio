#!/bin/bash

# 平均音量を目標値に近づけるように調整するためのスクリプト
target_volume=-24.0  # 目標の平均音量（dB）（Web制作コースの平均）

for file in *.mp4; do
  # 平均音量を測定
  mean_volume=$(ffmpeg -i "$file" -af "volumedetect" -vn -sn -dn -f null /dev/null 2>&1 | grep "mean_volume" | awk -F: '{print $2}' | awk '{print $1}')

  # 音量差を計算
  volume_diff=$(echo "$target_volume - $mean_volume" | bc)

  # 音量を一度正規化
  ffmpeg -i "$file" -af "volume=${volume_diff}dB" "temp_normalized_$file"

  # loudnormフィルタで更に高度な正規化
  ffmpeg -i "temp_normalized_$file" -af "loudnorm=I=-16:TP=-1.5:LRA=11" "final_normalized_$file"

  # 一時ファイルを削除
  rm "temp_normalized_$file"
done
