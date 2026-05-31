--테스트 데이터
-- 첫 번째 데이터 삽입
INSERT INTO "TODAY_LIST" ("TL_REG_DT", "TL_IDX", "TASK_ID", "EMP_ID")
VALUES (SYSTIMESTAMP, 1, 'T00001', 'E00001');

-- 두 번째 데이터 삽입
INSERT INTO "TODAY_LIST" ("TL_REG_DT", "TL_IDX", "TASK_ID", "EMP_ID")
VALUES (SYSTIMESTAMP, 2, 'T00002', 'E00002');

-- 세 번째 데이터 삽입
INSERT INTO "TODAY_LIST" ("TL_REG_DT", "TL_IDX", "TASK_ID", "EMP_ID")
VALUES (SYSTIMESTAMP, 3, 'T00003', 'E00003');

COMMIT;



--테스트 데이터
-- 첫 번째 데이터 삽입
INSERT INTO TASK ("TASK_ID", "TS_ID", "PRO_ID", "TASK_MAN_ID", "TASK_TOP_ID", "TPS_ID", "TASK_REG_ID", "TASK_TITLE", "TASK_REG_DT", "TASK_DDLINE_DT", "TASK_MOD_DT", "TASK_CN", "TASK_RQRD", "TASK_EST_TIME", "TASK_COMP_DT", "TASK_DEL_DT")
VALUES ('T00025', 'TS0001', 'P00001', 'E00001', '', 'T00001', 'E00002', 'test 11', SYSTIMESTAMP, NULL, SYSTIMESTAMP, 'Task Content 1', 10, 60, SYSTIMESTAMP, SYSTIMESTAMP);

-- 두 번째 데이터 삽입
INSERT INTO TASK ("TASK_ID", "TS_ID", "PRO_ID", "TASK_MAN_ID", "TASK_TOP_ID", "TPS_ID", "TASK_REG_ID", "TASK_TITLE", "TASK_REG_DT", "TASK_DDLINE_DT", "TASK_MOD_DT", "TASK_CN", "TASK_RQRD", "TASK_EST_TIME", "TASK_COMP_DT", "TASK_DEL_DT")
VALUES ('T00026', 'TS0002', 'P00002', 'E00001', '', 'T00001', 'E00002', 'test12', SYSTIMESTAMP, NULL, SYSTIMESTAMP, 'Task Content 2', 15, 90, SYSTIMESTAMP, SYSTIMESTAMP);

-- 세 번째 데이터 삽입
INSERT INTO TASK ("TASK_ID", "TS_ID", "PRO_ID", "TASK_MAN_ID", "TASK_TOP_ID", "TPS_ID", "TASK_REG_ID", "TASK_TITLE", "TASK_REG_DT", "TASK_DDLINE_DT", "TASK_MOD_DT", "TASK_CN", "TASK_RQRD", "TASK_EST_TIME", "TASK_COMP_DT", "TASK_DEL_DT")
VALUES ('T00027', 'TS0003', 'P00003', 'E00001', '', 'T00001', 'E00002', 'test 13', SYSTIMESTAMP, NULL, SYSTIMESTAMP, 'Task Content 3', 20, 120, SYSTIMESTAMP, SYSTIMESTAMP);

commit;

SELECT  TASK_MAN_ID FROM TASK
WHERE TASK_MAN_ID = 'E00001';
--일감ID, 일감상태 , [프로젝트 이름]일감제목 , 일감마감일

-- EMP_ID는 사원번호이고(조회시 나의 사원번호로 셋팅해줘야함 : REALUSER?) 인데 
-- 조인의 기준은 담당자의 아이디 ( 중심테이블은 TODAYL_LIST);

SELECT * FROM EMP;
-- 실제마감된 날  taksDdlineDt -> 실제 완료처리되면 헌재시간으로 업ㄷ데이트
-- 담당자가 정한 마감일 taskCompDt로

-- 오늘의 일정 목록조회 쿼리
SELECT 
A.*
, TSK.TS_ID
, TSK.PRO_ID
, TSK.TASK_TITLE
, TSK.TASK_MAN_ID
, TSK.TASK_EST_TIME
, TSK.TASK_RQRD
, TSK.TASK_REG_DT
, TSK.TASK_DDLINE_DT
, TSK.TASK_COMP_DT
FROM
( SELECT TL_IDX,TL_REG_DT,TASK_ID,TODAY_LIST.EMP_ID 
FROM TODAY_LIST
    JOIN EMP E ON ( TODAY_LIST.EMP_ID = E.EMP_ID)
)A  JOIN TASK TSK ON ( A.TASK_ID = TSK.TASK_ID)
WHERE A.EMP_ID ='E00001'
ORDER BY A.TL_IDX;

-- 일감조회 쿼리
WITH C AS (
    SELECT 
        TL.TL_IDX,
        TL.TL_REG_DT,
        TL.TASK_ID,
        TL.EMP_ID,
        E.EMP_NAME,
        TSK.TS_ID,
        TSK.PRO_ID,
        TSK.TASK_TITLE,
        TSK.TPS_ID,
        TSK.TASK_MAN_ID,
        TSK.TASK_REG_DT,
        TSK.TASK_COMP_DT,
        TS.TS_NAME,
        TPS.TPS_NAME,
        TPS.TPS_ING,
        TPS.TPS_DESC,
        PRO.PRO_NAME
    FROM 
        TODAY_LIST TL
        JOIN EMP E ON TL.EMP_ID = E.EMP_ID
        JOIN TASK TSK ON TL.TASK_ID = TSK.TASK_ID
        JOIN TASK_STATUS TS ON TS.TS_ID = TSK.TS_ID
        JOIN TASK_PROCESS_STATUS TPS ON TPS.TPS_ID = TSK.TPS_ID
        JOIN PROJECT PRO ON PRO.PRO_ID = TSK.PRO_ID
)
SELECT *
FROM C
WHERE C.TASK_MAN_ID = 'E00001'
ORDER BY C.TL_IDX;

-- 일감 조회 totalrecord 수 
	WITH C AS (
    SELECT 
        TL.TL_IDX,
        TL.TL_REG_DT,
        TL.TASK_ID,
        TL.EMP_ID,
        E.EMP_NAME,
        TSK.TS_ID,
        TSK.PRO_ID,
        TSK.TASK_TITLE,
        TSK.TPS_ID,
        TSK.TASK_MAN_ID,
        TSK.TASK_REG_DT,
        TSK.TASK_COMP_DT,
        TS.TS_NAME,
        TPS.TPS_NAME,
        TPS.TPS_ING,
        TPS.TPS_DESC,
        PRO.PRO_NAME
    FROM 
        TODAY_LIST TL
        JOIN EMP E ON TL.EMP_ID = E.EMP_ID
        JOIN TASK TSK ON TL.TASK_ID = TSK.TASK_ID
        JOIN TASK_STATUS TS ON TS.TS_ID = TSK.TS_ID
        JOIN TASK_PROCESS_STATUS TPS ON TPS.TPS_ID = TSK.TPS_ID
        JOIN PROJECT PRO ON PRO.PRO_ID = TSK.PRO_ID
)
SELECT COUNT(*)
FROM C
WHERE C.TASK_MAN_ID = 'E00001'
ORDER BY C.TL_IDX;

--오늘의 일정 단건조회

    
-- 검색조건의 프로젝트 목록  (현재 로그인한 유저의 사원번호기준)
-- 일감상태목록는 모든 일감상태 값 가져오기
-- 일감진행목록 10~ 100 전부 
-- 일감검색 시 보여지는 순서
WITH C AS (
    SELECT 
        TL.TL_IDX,
        TL.TL_REG_DT,
        TL.TASK_ID,
        TL.EMP_ID,
        E.EMP_NAME,
        TSK.TS_ID,
        TSK.PRO_ID,
        TSK.TASK_TITLE,
        TSK.TPS_ID,
        TSK.TASK_MAN_ID,
        TSK.TASK_REG_DT,
        TSK.TASK_COMP_DT,
        TS.TS_NAME,
        TPS.TPS_NAME,
        TPS.TPS_ING,
        TPS.TPS_DESC,
        PRO.PRO_NAME
    FROM 
        TODAY_LIST TL
        JOIN EMP E ON TL.EMP_ID = E.EMP_ID
        JOIN TASK TSK ON TL.TASK_ID = TSK.TASK_ID
        JOIN TASK_STATUS TS ON TS.TS_ID = TSK.TS_ID
        JOIN TASK_PROCESS_STATUS TPS ON TPS.TPS_ID = TSK.TPS_ID
        JOIN PROJECT PRO ON PRO.PRO_ID = TSK.PRO_ID
)
SELECT *
FROM C
WHERE C.TASK_MAN_ID = 'E00001'
ORDER BY C.TS_NAME;



 SELECT 
        TL.TL_IDX,
        TL.TL_REG_DT,
        TL.TASK_ID,
        TL.EMP_ID,
        E.EMP_NAME,
        TSK.TS_ID,
        TSK.PRO_ID,
        TSK.TASK_TITLE,
        TSK.TPS_ID,
        TSK.TASK_MAN_ID,
        TSK.TASK_REG_DT,
        TSK.TASK_COMP_DT
--        TS.TS_NAME,
--        TPS.TPS_NAME,
--        TPS.TPS_ING,
--        TPS.TPS_DESC,
--        PRO.PRO_NAME
    FROM 
        TODAY_LIST TL
        JOIN EMP E ON TL.EMP_ID = E.EMP_ID
        JOIN TASK TSK ON TL.TASK_ID = TSK.TASK_ID
    WHERE TSK.TASK_MAN_ID = 'E00001'

    
--    
--        JOIN TASK_STATUS TS ON TS.TS_ID = TSK.TS_ID
--        JOIN TASK_PROCESS_STATUS TPS ON TPS.TPS_ID = TSK.TPS_ID
--        JOIN PROJECT PRO ON PRO.PRO_ID = TSK.PRO_ID

--담당자가 정해진 일감을 우선조회하고 조인하기
WITH TEST AS (
    SELECT 
        A.*,   
        TS.TS_NAME,
        TPS.TPS_NAME,
        TPS.TPS_ING,
        TPS.TPS_DESC,
        PRO.PRO_NAME
    FROM (
        SELECT 
            ROWNUM RNUM,
            TASK_ID,
            TS_ID,
            PRO_ID,
            TASK_MAN_ID,
            TASK_TOP_ID,
            TPS_ID,
            TASK_REG_ID,
            TASK_TITLE,
            TASK_REG_DT,
            TASK_DDLINE_DT,
            TASK_RQRD,
            TASK_COMP_DT,
            TASK_CN
        FROM 
            TASK
        WHERE 
            TASK_MAN_ID = 'E00001' 
    ) A 
    JOIN 
        TASK_STATUS TS ON A.TS_ID = TS.TS_ID
    JOIN 
        TASK_PROCESS_STATUS TPS ON A.TPS_ID = TPS.TPS_ID
    JOIN 
        PROJECT PRO ON A.PRO_ID = PRO.PRO_ID
)
SELECT * FROM TEST 


-- 담당자가 로그인 유저인 경우
SELECT * FROM TASK WHERE TASK_MAN_ID = 'E00001';

-- 담당자가 로그인 유저인 경우와 프로젝트가 정해진 경우
SELECT * FROM TASK 
WHERE TASK_MAN_ID = 'E00001' AND PRO_ID ='P00001';

SELECT 
			ROWNUM AS RNUM,
		    TASK.task_id,
		    TASK.ts_id,
		    TASK.pro_id,
		    TASK.task_man_id,
		    TASK.task_top_id,
		    TASK.tps_id,
		    TASK.task_reg_id,
		    TASK.task_title,
		    TASK.task_reg_dt,
		    TASK.task_ddline_dt,
		    TASK.task_mod_dt,
		    TASK.task_cn,
		    TASK.task_rqrd,
		    TASK.task_est_time,
		    TASK.task_comp_dt,
		    TASK.task_del_dt,
		    PROJECT.PRO_NAME,
		    TS.TS_NAME,
		    TS.TS_TIME,
		    TPS.TPS_NAME,
		    TPS.TPS_ING,
		    TPS.TPS_DESC,
            EMP.EMP_NAME
		FROM
		    TASK 
		JOIN 
		    PROJECT ON TASK.PRO_ID = PROJECT.PRO_ID
		JOIN 
		    TASK_STATUS TS ON TASK.ts_id = TS.TS_ID
		JOIN 
		    TASK_PROCESS_STATUS TPS ON TASK.TPS_ID = TPS.TPS_ID
		JOIN 
			EMP ON TASK.task_man_id = EMP.EMP_ID
		WHERE 

        TASK.TASK_MAN_ID='E00002'
        AND
            TASK.ts_id ='T00002'
        AND				
            TASK.tps_id ='T00002'
            
      
--        OR INSTR(task_id, '#{detailCondition.word}') > 0 
--        OR INSTR(pro_name, '#{detailCondition.word}') > 0)

-- 오늘의 일정에 추가할 테이블 생성하기 ( 일감테이블에서 먼저 조회 후 오늘의일정 테이블과 조인하기)
--INSERT 
-- 조회 
WITH RET_TASK AS (
    SELECT 
        ROWNUM AS RNUM,
        TASK.task_id,
        TASK.ts_id,
        TASK.pro_id,
        TASK.task_man_id,
        TASK.task_top_id,
        TASK.tps_id,
        TASK.task_reg_id,
        TASK.task_title,
        TASK.task_reg_dt,
        TASK.task_ddline_dt,
        TASK.task_mod_dt,
        TASK.task_cn,
        TASK.task_rqrd,
        TASK.task_est_time,
        TASK.task_comp_dt,
        TASK.task_del_dt,
        PROJECT.PRO_NAME,
        TS.TS_NAME,
        TS.TS_TIME,
        TPS.TPS_NAME,
        TPS.TPS_ING,
        TPS.TPS_DESC,
        EMP.EMP_NAME
    FROM
        TASK 
    JOIN 
        PROJECT ON TASK.PRO_ID = PROJECT.PRO_ID
    JOIN 
        TASK_STATUS TS ON TASK.ts_id = TS.TS_ID
    JOIN 
        TASK_PROCESS_STATUS TPS ON TASK.TPS_ID = TPS.TPS_ID
    JOIN 
        EMP ON TASK.task_man_id = EMP.EMP_ID
    WHERE TASK.TASK_ID ='T00031'
)
SELECT
    TD.tl_reg_dt AS 일정등록일, -- TIMESTAMP
    TD.tl_idx AS 순번, -- INDEX
    TD.task_id AS 일감코드, -- 일감ID
    RET_TASK.task_man_id AS EMP_ID, -- 사원번호=담당자
    RET_TASK.TS_NAME AS 일감상태,--일감 제목
    RET_TASK.task_est_time AS 예상시간, --예상시간
    RET_TASK.task_reg_dt AS 소요시간, 
    
    
    --소요시간
    --작업상태
FROM
    today_list TD
JOIN RET_TASK ON TD.TASK_ID = RET_TASK.TASK_ID;

SELECT 
        ROWNUM AS RNUM,
        TASK.task_id,
        TASK.ts_id,
        TASK.pro_id,
        TASK.task_man_id,
        TASK.task_top_id,
        TASK.tps_id,
        TASK.task_reg_id,
        TASK.task_title,
        TASK.task_reg_dt,
        TASK.task_ddline_dt,
        TASK.task_mod_dt,
        TASK.task_cn,
        TASK.task_rqrd,
        TASK.task_est_time,
        TASK.task_comp_dt,
        TASK.task_del_dt,
        PROJECT.PRO_NAME,
        TS.TS_NAME,
        TS.TS_TIME,
        TPS.TPS_NAME,
        TPS.TPS_ING,
        TPS.TPS_DESC,
        EMP.EMP_NAME
    FROM
        TASK 
    JOIN 
        PROJECT ON TASK.PRO_ID = PROJECT.PRO_ID
    JOIN 
        TASK_STATUS TS ON TASK.ts_id = TS.TS_ID
    JOIN 
        TASK_PROCESS_STATUS TPS ON TASK.TPS_ID = TPS.TPS_ID
    JOIN 
        EMP ON TASK.task_man_id = EMP.EMP_ID
    WHERE 

    TASK.TASK_ID = 'T00031'
    
CREATE SEQUENCE today_list_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999
    NOCACHE
    NOCYCLE;
    
--DROP TRIGGER today_list_trigger;    
CREATE OR REPLACE TRIGGER today_list_trigger
BEFORE INSERT ON today_list
FOR EACH ROW
BEGIN
    :new.tl_idx := today_list_seq.NEXTVAL; -- 하나씪 반환해주는 시퀀스
END;


INSERT INTO today_list (tl_reg_dt, task_id, emp_id)
VALUES (SYSTIMESTAMP, 'T00031', 'E00001');

	SELECT 
			ROWNUM AS RNUM,
		    TASK.task_id,
		    TASK.ts_id,
		    TASK.pro_id,
		    TASK.task_man_id,
		    TASK.task_top_id,
		    TASK.tps_id,
		    TASK.task_reg_id,
		    TASK.task_title,
		    TASK.task_reg_dt,
		    TASK.task_ddline_dt,
		    TASK.task_mod_dt,
		    TASK.task_cn,
		    TASK.task_rqrd,
		    TASK.task_est_time,
		    TASK.task_comp_dt,
		    TASK.task_del_dt,
		    PROJECT.PRO_NAME,
		    TS.TS_NAME,
		    TS.TS_TIME,
		    TPS.TPS_NAME,
		    TPS.TPS_ING,
		    TPS.TPS_DESC,
            EMP.EMP_NAME
		FROM
		    TASK 
		JOIN 
		    PROJECT ON TASK.PRO_ID = PROJECT.PRO_ID
		JOIN 
		    TASK_STATUS TS ON TASK.ts_id = TS.TS_ID
		JOIN 
		    TASK_PROCESS_STATUS TPS ON TASK.TPS_ID = TPS.TPS_ID
		JOIN 
			EMP ON TASK.task_man_id = EMP.EMP_ID
		WHERE 
		    TASK.TASK_MAN_ID= 'T00031'
		     or TASK.tps_id != 'T00007'