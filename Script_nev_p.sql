DROP VIEW nev;

CREATE VIEW nev AS
WITH pg2 AS
(SELECT playerid, library, CONCAT('"', REPLACE(library, ', ', '""'), '"') as library2 FROM purchased_games)
SELECT 
g.gameid,
CONCAT('"', g.gameid, '"') AS gameid_guillemets,
SUM((LENGTH(pg2.library2) - LENGTH(REPLACE(pg2.library2, gameid_guillemets, ''))) / LENGTH(gameid_guillemets)) AS nev_,
FROM games g
JOIN achievements a ON a.gameid = g.gameid
JOIN history h ON h.achievementid = a.achievementid
JOIN pg2 ON pg2.playerid = h.playerid
GROUP BY g.gameid;

SELECT * FROM nev;

DROP view nev2;

CREATE VIEW nev2 AS
SELECT g.gameid, g.title, g.genres, g.platform, g.supported_languages, SUM(nev.nev_) as total_nev,
(SUM(nev.nev_)/(SELECT SUM(nev.nev_) FROM nev)*100) AS pourcentage
FROM games g
JOIN nev ON nev.gameid = g.gameid
GROUP BY g.gameid, g.title, g.genres, g.platform, g.supported_languages
ORDER BY SUM(nev.nev_) DESC;

SELECT * FROM nev2;
