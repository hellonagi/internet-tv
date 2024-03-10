# ステップ1

## ER図

![ER図](/er_diagram.png)


## テーブル設計

テーブル：channels (チャンネル)

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|----|----|----|----|----|----|
|id|int||PRIMARY||YES|
|name|varchar(100)||UNIQUE|||

- ユニークキー制約：name カラムに対して設定


テーブル：programs (番組)

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|----|----|----|----|----|----|
|id|int||PRIMARY||YES|
|title|varchar(100)|||||
|details|varchar(1000)|||||


テーブル：schedules (番組枠)

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|----|----|----|----|----|----|
|id|int||PRIMARY||YES|
|channel_id|int||FOREIGN|||
|program_id|int||FOREIGN|||
|start_air_time|time||||
|end_air_time|time||||

- 外部キー制約：channel_id に対して、channels テーブルの id カラムから設定
- 外部キー制約：program_id に対して、programs テーブルの id カラムから設定


テーブル：seasons (シーズン)

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|----|----|----|----|----|----|
|id|int||PRIMARY||YES|
|program_id|int||FOREIGN|||
|season_no|smallint|||||

- 外部キー制約：program_id に対して、programs テーブルの id カラムから設定


テーブル：episodes (エピソード)

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|----|----|----|----|----|----|
|id|int||PRIMARY||YES|
|season_id|int||FOREIGN|||
|episode_no|smallint|||||
|title|varchar(100)|||||
|details|varchar(1000)|||||
|duration|int|||||
|public_at|datetime||||

- 外部キー制約：season_id に対して、seasons テーブルの id カラムから設定


テーブル：viewers (視聴者情報)

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|----|----|----|----|----|----|
|id|int||PRIMARY||YES|
|schedule_id|int||FOREIGN|||
|episode_id|int||FOREIGN|||
|view_count|int|||||

- 外部キー制約：schedule_id に対して、schedules テーブルの id カラムから設定
- 外部キー制約：episode_id に対して、episodes テーブルの id カラムから設定


テーブル：genres (ジャンル)

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|----|----|----|----|----|----|
|id|int||PRIMARY||YES|
|name|varchar(32)||UNIQUE|||

- ユニークキー制約：name カラムに対して設定


テーブル：programs_genres (番組ジャンル)

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
|----|----|----|----|----|----|
|id|int||PRIMARY||YES|
|program_id|int||FOREIGN|||
|genre_id|int||FOREIGN|||

- 外部キー制約：program_id に対して、programs テーブルの id カラムから設定
- 外部キー制約：genre_id に対して、genres テーブルの id カラムから設定