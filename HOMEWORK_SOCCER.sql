-- 1
SELECT PLAYER_NAME, POSITION, HEIGHT
FROM PLAYER
WHERE TEAM_ID IN ('K02', 'K05');

-- 2
SELECT PLAYER_NAME, NATION
FROM PLAYER
WHERE NATION IS NOT NULL;

-- 3
SELECT PLAYER_ID, POSITION, BACK_NO, TEAM_ID, HEIGHT
FROM PLAYER
WHERE TEAM_ID IN ('K02', 'K07');

-- 4
SELECT ZIP_CODE1 || '-' ||ZIP_CODE2 우편번호
FROM TEAM;

-- 5
SELECT COUNT(*), COUNT(HEIGHT), ROUND(AVG(HEIGHT)), MAX(HEIGHT), MIN(HEIGHT)
FROM PLAYER;

-- 6
SELECT TEAM_ID, COUNT(PLAYER_NAME)
FROM PLAYER
GROUP BY TEAM_ID
ORDER BY 2 DESC;

-- 7
SELECT PLAYER_NAME, TEAM_NAME
FROM PLAYER
JOIN TEAM USING (TEAM_ID);

-- 8
SELECT PLAYER_NAME, POSITION, NATION, TEAM_NAME, STADIUM_NAME
FROM PLAYER
JOIN TEAM USING (TEAM_ID)
JOIN STADIUM USING (STADIUM_ID);

-- 9
SELECT TEAM_NAME, T.STADIUM_ID, STADIUM_NAME
FROM TEAM T, STADIUM S
WHERE T.TEAM_ID = S.HOMETEAM_ID(+);

-- 10
SELECT PLAYER_NAME, POSITION, BACK_NO
FROM PLAYER 
WHERE HEIGHT >= (SELECT SUM(HEIGHT)/COUNT(HEIGHT) FROM PLAYER);

-- 11
SELECT TEAM_NAME, E_TEAM_NAME, REGION_NAME
FROM PLAYER P, TEAM T
WHERE P.TEAM_ID = T.TEAM_ID
AND PLAYER_NAME = '정현수';

-- 12
SELECT TEAM_NAME, PLAYER_NAME, POSITION, BACK_NO, HEIGHT
FROM PLAYER P, (SELECT TEAM_ID, AVG(HEIGHT) KEY
                FROM PLAYER
                GROUP BY TEAM_ID) F, TEAM T
WHERE P.TEAM_ID = F.TEAM_ID
AND P.TEAM_ID = T.TEAM_ID
AND HEIGHT <= F.KEY;

SELECT M.TEAM_ID, TEAM_NAME 팀명, PLAYER_NAME 선수명, POSITION 포지션, BACK_NO 등번호, HEIGHT 신장길이
FROM PLAYER M
JOIN TEAM T ON(M.TEAM_ID = T.TEAM_ID)
WHERE HEIGHT < (SELECT AVG(HEIGHT)
                FROM PLAYER 
                GROUP BY M.TEAM_ID)
ORDER BY 1;
-- 13
CREATE OR REPLACE VIEW V_TEAM_PLAYER
AS SELECT PLAYER_NAME, POSITION, BACK_NO, P.TEAM_ID, TEAM_NAME
   FROM PLAYER P, TEAM T
   WHERE P.TEAM_ID = T.TEAM_ID;

SELECT *
FROM V_TEAM_PLAYER
WHERE PLAYER_NAME LIKE '황%';

-- 14
INSERT INTO PLAYER
VALUES((SELECT MAX(PLAYER_ID)
FROM PLAYER)+1, '박주호', 'K01', 'PARK, JUHO', 'GAEBAL', 2020, 'DF', 10, NULL, '87/03/16',1, 176, 75); 

-- 15
UPDATE TEAM T
SET ADDRESS = (SELECT STADIUM_NAME
               FROM STADIUM S
               WHERE T.STADIUM_ID = S.STADIUM_ID);

-- 16
SELECT SCHE_DATE, STADIUM_NAME, B.TEAM_NAME HOME, D.TEAM_NAME AWAY, HOME_SCORE, AWAY_SCORE
FROM (SELECT * FROM SCHEDULE WHERE HOME_SCORE+AWAY_SCORE = (SELECT MAX(HOME_SCORE+AWAY_SCORE) FROM SCHEDULE)) A, TEAM B, TEAM D, STADIUM C
WHERE A.STADIUM_ID = C.STADIUM_ID
AND A.HOMETEAM_ID = B.TEAM_ID
AND A.AWAYTEAM_ID = D.TEAM_ID;

-- 17
DECLARE
    S STADIUM%ROWTYPE;
BEGIN
    FOR S IN (SELECT * FROM STADIUM WHERE HOMETEAM_ID IS NULL)
    LOOP
        UPDATE STADIUM
        SET HOMETEAM_ID = 'K'|| (SELECT SUBSTR(MAX(HOMETEAM_ID),2)+1 FROM STADIUM)
        WHERE STADIUM_ID = S.STADIUM_ID;
    END LOOP;
END;
/

-- 18
-- 19
--> 답지 참고

















