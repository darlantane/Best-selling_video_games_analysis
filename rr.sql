DROP VIEW rr;

CREATE VIEW rr AS
SELECT r.reviewid, r.gameid, r.helpful, r.funny, r.awards, nev2.title, nev2.genres, nev2.platform, nev2.total_nev FROM reviews r
JOIN nev2 ON nev2.gameid=r.gameid;

SELECT * FROM rr;
