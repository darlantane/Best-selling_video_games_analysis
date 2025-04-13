DROP VIEW ach;

CREATE VIEW ach AS
SELECT h.achievementid, a.title, g.title as game_title, g.genres, pl.nickname, pl.country, a.rarity, a.points, h.date_acquired, h.platform
FROM history h
JOIN achievements a ON a.achievementid=h.achievementid
JOIN players pl ON pl.playerid=h.playerid
JOIN games g ON g.gameid=a.gameid;

SELECT * FROM ach;
