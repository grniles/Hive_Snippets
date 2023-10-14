DROP TABLE IF EXISTS batting;
CREATE EXTERNAL TABLE IF NOT EXISTS batting(id STRING, year INT, team STRING, league STRING, games INT, ab INT, runs INT, hits INT, doubles INT, triples INT, homeruns INT, rbi INT, sb INT, cs INT, walks INT, strikeouts INT, ibb INT, hbp INT, sh INT, sf INT, gidp INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/hivetest/batting';
DROP TABLE IF EXISTS master;
CREATE EXTERNAL TABLE IF NOT EXISTS master(id STRING, byear INT, bmonth INT, bday INT, bcountry STRING, bstate STRING, bcity STRING, dyear INT, dmonth INT, dday INT, dcountry STRING, dstate STRING, dcity STRING, fname STRING, lname STRING, name STRING, weight INT, height INT, bats STRING, throws STRING, debut STRING, finalgame STRING, retro STRING, bbref STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '/user/maria_dev/hivetest/master';

DROP VIEW IF EXISTS rightyBornDies;
CREATE VIEW rightyBornDies
AS SELECT b.id, SUM(b.hits) AS sumHits
FROM batting b
JOIN master m ON m.id = b.id
WHERE m.bats = 'R' AND m.bmonth = 10 AND m.dyear = 2011
GROUP BY b.id;

SELECT id FROM rightyBornDies
JOIN (SELECT MAX(sumHits) AS maxHits FROM rightyBornDies) AS max
ON max.maxHits = rightyBornDies.sumHits;



SELECT rosterPosition, COUNT(rosterPosition) AS cnt
FROM positionInjury
GROUP BY rosterPosition
ORDER BY cnt DESC;