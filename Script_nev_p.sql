DROP VIEW nq_p;

CREATE VIEW nq_p AS
SELECT playerid, library, REPLACE(REPLACE(REPLACE(REPLACE(library, '[', '"'), ']', '"'), ',', '"'), ' ', '"') as library2 FROM purchased_games_playstation;

SELECT * FROM nq_p;

DROP VIEW nev_p;

CREATE VIEW nev_p AS
SELECT 
    g.gameid,
    CONCAT('"', g.gameid, '"') AS gameid_guillemets,
    SUM((LENGTH(nq_p.library2) - LENGTH(REPLACE(nq_p.library2, gameid_guillemets, ''))) / LENGTH(gameid_guillemets)) AS nombre_exemplaires_vendus
FROM games_playstation g
JOIN achievements_playstation ON achievements_playstation.gameid = g.gameid
JOIN history_playstation ON history_playstation.achievementid = achievements_playstation.achievementid
JOIN nq_p ON nq_p.playerid = history_playstation.playerid
GROUP BY g.gameid;

SELECT * FROM nev_p;

DROP VIEW games_nev_p;

CREATE VIEW games_nev_p AS
SELECT DISTINCT
nev_p.gameid, g.title, g.platform, 
REPLACE(REPLACE(g.genres, '[', ''), ']', '') AS genres_, 
REPLACE(REPLACE(g.developers, '[', ''), ']', '') AS developers_,
REPLACE(REPLACE(g.supported_languages, '[', ''), ']', '') AS supported_languages_, 
g.release_date, nev_p.nombre_exemplaires_vendus,
p.usd*nombre_exemplaires_vendus AS ca_usd,
p.eur*nombre_exemplaires_vendus AS ca_eur,
p.gbp*nombre_exemplaires_vendus AS ca_gbp,
p.jpy*nombre_exemplaires_vendus AS ca_jpy,
p.rub*nombre_exemplaires_vendus AS ca_rub
FROM nev_p
JOIN games_playstation g ON nev_p.gameid = g.gameid
JOIN prices_playstation p ON nev_p.gameid = p.gameid
JOIN achievements_playstation a ON a.gameid = g.gameid
JOIN history_playstation h ON h.achievementid = a.achievementid;

SELECT * FROM games_nev_p;