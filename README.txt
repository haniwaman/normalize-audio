## 実行方法

- 音量を調整したい動画をフォルダにまとめる
- ターミナルでnormalize-audio.shが格納されたフォルダに移動する
- 以下のコマンドを実行する。/path/to/directoryは動画フォルダを指定する
```
./normalize-audio.sh /path/to/directory
```
- normalizedフォルダに調整後のファイルが出力される。サフィックスに「_normalized」がついたファイル名に変換される。

## 音量の調整方法
target_volume=-24.0の「-24.0」はWeb制作コースの平均の音量です。
check-mean-volume.shで測れますので、アップロードされている既存の動画から確認してみてください。