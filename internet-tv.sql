-- データベース作成

DROP DATABASE IF EXISTS internet_tv;
CREATE DATABASE IF NOT EXISTS internet_tv;
USE internet_tv;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS channels,
                     programs,
                     schedules,
                     seasons, 
                     episodes,
                     viewers,
                     genres,
                     programs_genres;


-- テーブル作成

USE internet_tv;

CREATE TABLE channels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE
);

CREATE TABLE programs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    details VARCHAR(1000) NOT NULL
);

CREATE TABLE schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    channel_id INT NOT NULL,
    program_id INT NOT NULL,
    start_air_time TIME NOT NULL,
    end_air_time TIME NOT NULL,
    FOREIGN KEY (channel_id) REFERENCES channels(id),
    FOREIGN KEY (program_id) REFERENCES programs(id)
);

CREATE TABLE seasons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    program_id INT NOT NULL,
    season_no SMALLINT,
    FOREIGN KEY (program_id) REFERENCES programs(id)
);

CREATE TABLE episodes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    season_id INT,
    episode_no SMALLINT,
    title VARCHAR(100) NOT NULL,
    details VARCHAR(1000) NOT NULL,
    duration INT NOT NULL,
    public_at DATE NOT NULL,
    FOREIGN KEY (season_id) REFERENCES seasons(id)
);

CREATE TABLE viewers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    schedule_id INT NOT NULL,
    episode_id INT NOT NULL,
    view_count INT NOT NULL DEFAULT 0,
    FOREIGN KEY (schedule_id) REFERENCES schedules(id),
    FOREIGN KEY (episode_id) REFERENCES episodes(id)
);

CREATE TABLE genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE programs_genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    program_id INT NOT NULL,
    genre_id INT NOT NULL,
    FOREIGN KEY (program_id) REFERENCES programs(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

-- サンプルデータ入力

SELECT 'LOADING channels' as 'INFO';
source load_channels.sql;
SELECT 'LOADING programs' as 'INFO';
source load_programs.sql;
SELECT 'LOADING schedules' as 'INFO';
source load_schedules.sql;
SELECT 'LOADING genres' as 'INFO';
source load_genres.sql;
SELECT 'LOADING programs_genres' as 'INFO';
source load_programs_genres.sql;
SELECT 'LOADING seasons' as 'INFO';
source load_seasons.sql;
SELECT 'LOADING episodes' as 'INFO';
source load_episodes.sql;
SELECT 'LOADING viewers' as 'INFO';
source load_viewers.sql;