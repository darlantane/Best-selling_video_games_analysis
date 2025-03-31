DROP VIEW ach_p;

CREATE VIEW ach_p AS
SELECT h.achievementid, g.title AS jeu, p.nickname, p.country, a.title, a.description, a.rarity, REPLACE(h.date_acquired, ';;;;', '') AS date_acquired
FROM history_playstation h
JOIN achievements_playstation a ON a.achievementid=h.achievementid
JOIN players_playstation p ON p.playerid=h.playerid
JOIN games_playstation g ON g.gameid=a.gameid;

SELECT * FROM ach_p;