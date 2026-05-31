CREATE TABLE WEATHER (
    WEATHER_ID CHAR(6),
    WEATHER_TYPE VARCHAR2(100),
    DUST VARCHAR2(50),
    UV VARCHAR2(50),
    TEMP VARCHAR2(20)
);


COMMIT;

SELECT * FROM WEATHER;
--날씨는 이미 데이터가 존재하며
-- 음식목록을 눌렀을 때 쌓이는 X_TRAIN은 사원(연령,성별)ID, 날씨ID, 음식ID,조회시간
-- food_Views 테이블 
CREATE TABLE "FOOD_VIEWS" 
   ("EMP_ID" CHAR(6 BYTE) NOT NULL ENABLE, 
	"WEATHER_ID" CHAR(6 BYTE) NOT NULL ENABLE, 
    "FOOD_ID" CHAR(6 BYTE) NOT NULL ENABLE, 
	"VIEW_YMD" TIMESTAMP (6) DEFAULT SYSTIMESTAMP  NULL ENABLE
) 

INSERT INTO FOOD_VIEWS ( EMP_ID,WEATHER_ID ,FOOD_ID,VIEW_YMD) VALUES ( 'E00001','0', '4','24/02/23 17:59:07.648000000');
INSERT INTO FOOD_VIEWS ( EMP_ID,WEATHER_ID ,FOOD_ID,VIEW_YMD) VALUES ( 'E00002','1', '3','24/02/21 18:41:49.473000000');
INSERT INTO FOOD_VIEWS ( EMP_ID,WEATHER_ID ,FOOD_ID,VIEW_YMD) VALUES ( 'E00006','2', '2','24/02/21 17:30:39.616000000');
INSERT INTO FOOD_VIEWS ( EMP_ID,WEATHER_ID ,FOOD_ID,VIEW_YMD) VALUES ( 'E00008','3', '1','24/02/21 17:30:38.303000000');
INSERT INTO FOOD_VIEWS ( EMP_ID,WEATHER_ID ,FOOD_ID,VIEW_YMD) VALUES ( 'E00010','4', '5','24/02/23 17:59:13.834000000');

COMMIT;
SELECT * FROM FOOD_VIEWS;
-- EMP 테이블과 사원이 조회한 데이터 테이블(food_views)와 조인해서 숫자로 된 X_TRAIN 뽑기 

         SELECT 
                FOOD_VIEWS.EMP_ID,
                CASE 
                    WHEN EMP.EMP_AGE < 30 THEN '0'
                    WHEN EMP.EMP_AGE < 40 THEN '1'
                    WHEN EMP.EMP_AGE < 50 THEN '2'
                    WHEN EMP.EMP_AGE < 60 THEN '3'
                    ELSE '4'
                END AS AGE,
                CASE 
                    WHEN EMP.EMP_GEN = 'F' THEN '0'
                    WHEN EMP.EMP_GEN = 'M' THEN '1'
                END AS GEN,
                TRIM(FOOD_VIEWS.WEATHER_ID ) AS WEATHER_ID
             
            FROM 
                FOOD_VIEWS 
                JOIN EMP ON FOOD_VIEWS.EMP_ID = EMP.EMP_ID
                JOIN WEATHER ON FOOD_VIEWS.WEATHER_ID = WEATHER.WEATHER_ID
                JOIN FOOD ON FOOD_VIEWS.FOOD_ID = FOOD.FOOD_ID  
            ORDER BY FOOD_VIEWS.EMP_ID
-- y train 

SELECT 
    FOOD.FOOD_ID
FROM 
    FOOD_VIEWS 
JOIN 
    FOOD ON FOOD_VIEWS.FOOD_ID = FOOD.FOOD_ID
ORDER BY FOOD_VIEWS.WEATHER_ID;

-- XY TRAIN  : 어떤 연령(X),성별(x)의 사원이 어떤 날씨(X)에 음식점(Y)을 골랐다
SELECT 
--    EMP.EMP_ID AS EMP_ID,
    TRIM(FOOD_VIEWS.WEATHER_ID ) AS WEATHER_ID,
    TRIM(FOOD_VIEWS.FOOD_ID ) AS FOOD_ID,
    CASE 
        WHEN EMP.EMP_AGE < 30 THEN '0'
        WHEN EMP.EMP_AGE < 40 THEN '1'
        WHEN EMP.EMP_AGE < 50 THEN '2'
        WHEN EMP.EMP_AGE < 60 THEN '3'
        ELSE '4'
    END AS AGE,
    CASE 
        WHEN EMP.EMP_GEN = 'F' THEN '0'
        WHEN EMP.EMP_GEN = 'M' THEN '1'
    END AS GEN              
 
FROM 
    FOOD_VIEWS 
    JOIN EMP ON FOOD_VIEWS.EMP_ID = EMP.EMP_ID
    JOIN WEATHER ON FOOD_VIEWS.WEATHER_ID = WEATHER.WEATHER_ID
    JOIN FOOD ON FOOD_VIEWS.FOOD_ID = FOOD.FOOD_ID  
ORDER BY FOOD_VIEWS.WEATHER_ID


--food Recom

CREATE TABLE "FOOD_RECOM" 
   (
   "WEATHER_ID" VARCHAR2(20 BYTE) NOT NULL ENABLE,
   "FOOD_ID" CHAR(6 BYTE) NOT NULL ENABLE, 
   "AGE" CHAR(6 BYTE) NOT NULL ENABLE, 
    "GEN" CHAR(6 BYTE) NOT NULL ENABLE,
    "RANK" VARCHAR2(20 BYTE) NOT NULL ENABLE
   ) 
select * from food_recom;


select * from food;



-- 자바 mapper.xml
SELECT
   WEATHER_ID,
   WEATHER_TYPE,
   DUST,
   UV,
   TEMP
FROM
    WEATHER
    
SELECT 
        TRIM(WEATHER_ID) AS WEATHER_ID,
        WEATHER_TYPE,
        DUST,
        UV,
        TEMP
    FROM 
        WEATHER
    WHERE
        ROWID = (SELECT MAX(ROWID) FROM WEATHER)



--추천리스트 결과 조회 쿼리

select 
        WEATHER_ID
        ,FOOD_ID
        ,AGE
        ,GEN
        ,RANK
from food_recom 


SELECT 
    F.FOOD_ID,
    F.FOOD_PLACE,
    F.FOOD_NAME,
    F.FOOD_TEL,
    F.FOOD_ADDR,
    F.FOOD_IMGURL,
    F.FOOD_OPENTIME,
    F.FOOD_CLOSETIME,
    FR.WEATHER_ID,
    FR.RANK
FROM 
    FOOD F
    JOIN FOOD_RECOM FR ON F.FOOD_ID = FR.FOOD_ID
WHERE 
    FR.AGE = '0' AND 
    FR.GEN = '1' AND 
    FR.WEATHER_ID = '3'
ORDER BY 
    FR.RANK;


SELECT 
    F.FOOD_ID,
    F.FOOD_PLACE,
    F.FOOD_NAME,
    F.FOOD_TEL,
    F.FOOD_ADDR,
    F.FOOD_IMGURL,
    F.FOOD_OPENTIME,
    F.FOOD_CLOSETIME,
    FR.WEATHER_ID,
    FR.RANK
FROM 
    FOOD F
    JOIN FOOD_RECOM FR ON F.FOOD_ID = FR.FOOD_ID
WHERE 
    FR.AGE = '0' AND 
    FR.GEN = '1' AND 
    FR.WEATHER_ID = '1'
    AND ROWNUM <= 3
ORDER BY 
    FR.RANK ;
	