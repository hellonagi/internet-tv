-- エピソード視聴数トップ3のエピソードタイトルと視聴数を取得

SELECT E.title AS 'エピソードタイトル', V.view_count AS '視聴者数'
FROM episodes AS E
INNER JOIN viewers AS V
ON E.id = V.episode_id
ORDER BY V.view_count DESC
LIMIT 3;


-- エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得

SELECT P.title AS '番組タイトル', S.season_no AS 'シーズン数', E.episode_no
  AS 'エピソード数',E.title AS 'エピソードタイトル', V.view_count AS '視聴数'
FROM programs AS P
INNER JOIN seasons AS S
ON P.id = S.program_id
INNER JOIN episodes AS E
ON S.id = E.season_id
INNER JOIN viewers AS V
ON E.id = V.episode_id
ORDER BY V.view_count DESC
LIMIT 3;


-- 本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、
-- シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得
-- なお、番組の開始時刻が本日のものを本日放送される番組とみなす

SELECT Ch.name AS 'チャンネル名', CONCAT(Ep.public_at, ' ', Sc.start_air_time) AS '放送開始時刻',
  Sc.end_air_time AS '放送終了時刻', Se.season_no AS 'シーズン数', Ep.episode_no AS 'エピソード数',
  Ep.title AS 'エピソードタイトル', Ep.details AS 'エピソード詳細'
FROM channels AS Ch
INNER JOIN schedules AS Sc
ON Ch.id = Sc.channel_id
INNER JOIN programs AS Pr
ON Pr.id = Sc.program_id
INNER JOIN seasons AS Se
ON Pr.id = Se.program_id
INNER JOIN episodes AS Ep
ON Se.id = Ep.season_id
WHERE DATE(Ep.public_at) = CURRENT_DATE
ORDER BY Ch.id, Sc.start_air_time;


-- ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、
-- エピソードタイトル、エピソード詳細を本日から一週間分取得

SELECT CONCAT(Ep.public_at, ' ', Sc.start_air_time) AS '放送開始時刻', Sc.end_air_time AS '放送終了時刻',
  Se.season_no AS 'シーズン数', Ep.episode_no AS 'エピソード数', Ep.title AS 'エピソードタイトル',
  Ep.details AS 'エピソード詳細'
FROM channels AS Ch
INNER JOIN schedules AS Sc
ON Ch.id = Sc.channel_id
INNER JOIN programs AS Pr
ON Pr.id = Sc.program_id
INNER JOIN seasons AS Se
ON Pr.id = Se.program_id
INNER JOIN episodes AS Ep
ON Se.id = Ep.season_id
WHERE Ch.name = 'ドラマ'
AND Ep.public_at BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL 7 DAY
ORDER BY CAST(CONCAT(Ep.public_at, ' ', Sc.start_air_time) AS DATETIME);


-- 直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得

SELECT P.title AS '番組タイトル', SUM(V.view_count) AS '視聴数'
FROM programs AS P
INNER JOIN seasons AS S
ON P.id = S.program_id
INNER JOIN episodes AS E
ON S.id = E.season_id
INNER JOIN viewers AS V
ON E.id = V.episode_id
WHERE E.public_at BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL 7 DAY
GROUP BY P.id 
ORDER BY SUM(V.view_count) DESC
LIMIT 2;


-- 番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、
-- ジャンル名、番組タイトル、エピソード平均視聴数を取得

SELECT genre_name AS 'ジャンル名', program_title AS '番組タイトル', ROUND(MAX(avg_view_count)) AS 'エピソード平均視聴者数'
FROM (
  SELECT G.id AS genre_id, G.name AS genre_name, P.title AS program_title, AVG(V.view_count) AS avg_view_count
  FROM programs AS P
  INNER JOIN seasons AS S
  ON P.id = S.program_id
  INNER JOIN episodes AS E
  ON S.id = E.season_id
  INNER JOIN viewers AS V
  ON E.id = V.episode_id
  INNER JOIN programs_genres AS PG
  ON P.id = PG.program_id
  INNER JOIN genres AS G
  ON G.id = PG.genre_id
  GROUP BY G.id, P.id
) AS A
GROUP BY genre_id
ORDER BY genre_id;
