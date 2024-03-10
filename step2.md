# ステップ2

## 動作保証環境
- MySQL 8.0.28
- git 2.43.0
- Windows 11

## サンプルデータの保存

任意のフォルダで下記コマンドを実行してください。
```
git clone git@github.com:hellonagi/internet-tv.git
```

## サンプルデータの読み込み

保存先のフォルダに移動します。
```
cd internet-tv
```

サンプルデータを読み込みます。
```
mysql < internet-tv.sql -u <ユーザー名> -p --default-character-set=utf8mb4
```

## 注意事項
- internet_tvデータベースが既に存在している場合上書きされます。
- WindowsユーザーはPowerShellではなくコマンドプロントを使用してください。