#!/bin/bash

# -----
# 平均音量を目標値に近づけるように調整するためのスクリプト
# -----

# 対象となるディレクトリのパス
# 例）/path/to/directory
target_dir="$1"

# 目標の平均音量（dB）
target_volume=-24.0  # 目標の平均音量（dB）（Web制作コースの平均）

# 指定されたディレクトリに移動
cd "$target_dir" || { echo "Directory not found: $target_dir"; exit 1; }

# 出力用のフォルダを作成
mkdir -p "normalized"

for file in *.mp4; do
  filename=$(basename -- "$file") # ファイル名と拡張子を分けるためにbasenameコマンドを使用
  extension="${filename##*.}" # '##*' 演算子を使用して、ファイル名から拡張子を取り出す
  filename_no_ext="${filename%.*}" # '%.*' 演算子を使用して、ファイル名から拡張子を除去する

  # 平均音量を測定
  mean_volume=$(ffmpeg -i "$file" -af "volumedetect" -vn -sn -dn -f null /dev/null 2>&1 | grep "mean_volume" | awk -F: '{print $2}' | awk '{print $1}')

  # 音量差を計算
  volume_diff=$(echo "$target_volume - $mean_volume" | bc)

  # 音量を一度正規化
  ffmpeg -i "$file" -af "volume=${volume_diff}dB" "normalized/${filename_no_ext}_normalized.$extension" # loudnormフィルタを使う場合は"temp_normalized_$file"

  # loudnormフィルタで更に高度な正規化
  # ffmpeg -i "temp_normalized_$file" -af "loudnorm=I=${target_volume}:TP=-1.5:LRA=11" "final_normalized_$file"

  # 一時ファイルを削除
  # rm "temp_normalized_$file"
done
