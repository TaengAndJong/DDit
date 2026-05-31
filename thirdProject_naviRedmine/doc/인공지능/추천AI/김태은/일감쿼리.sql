-- 일감조회 -조건은 프로젝트 아이디
SELECT * FROM PROJECT;
-- 일감목록쿼리
SELECT 
    P.PRO_NAME,
    T.TASK_ID,
    T.TS_ID,
    T.PRO_ID,
    T.TASK_MAN_ID,
    T.TASK_TOP_ID,
    T.TPS_ID,
    T.TASK_REG_ID,
    T.TASK_TITLE,
    T.TASK_REG_DT,
    T.TASK_DDLINE_DT,
    T.TASK_MOD_DT,
    T.TASK_CN,
    T.TASK_RQRD,
    T.TASK_EST_TIME,
    T.TASK_COMP_DT
 
FROM 
    TASK T
JOIN 
    PROJECT P ON T.PRO_ID = P.PRO_ID
WHERE 
    T.PRO_ID = 'P00001';



 SELECT 
	        P.PRO_NAME,
	        T.TASK_ID,
	        T.TS_ID,
	        T.PRO_ID,
	        T.TASK_MAN_ID,
	        T.TASK_TOP_ID,
	        T.TPS_ID,
	        T.TASK_REG_ID,
	        T.TASK_TITLE,
	        T.TASK_REG_DT,
	        T.TASK_DDLINE_DT,
	        T.TASK_MOD_DT,
	        T.TASK_CN,
	        T.TASK_RQRD,
	        T.TASK_EST_TIME,
	        T.TASK_COMP_DT
	    FROM 
	        TASK T
	    JOIN 
	        PROJECT P ON T.PRO_ID = P.PRO_ID;
            
SELECT 
        P.PRO_NAME,
        T.TASK_ID,
        T.PRO_ID,
        T.TASK_MAN_ID,
        T.TASK_TOP_ID,
        T.TPS_ID,
        T.TASK_REG_ID,
        T.TASK_TITLE,
        T.TASK_REG_DT,
        T.TASK_DDLINE_DT,
        T.TASK_MOD_DT,
        T.TASK_CN,
        T.TASK_RQRD,
        T.TASK_EST_TIME,
        T.TASK_COMP_DT
FROM 
    TASK T
JOIN 
    PROJECT P ON T.PRO_ID = P.PRO_ID;
    



WITH TaskProject AS (
    SELECT 
        ROWNUM,
        T.TASK_ID,
        T.TS_ID, 
        T.PRO_ID,
        T.TPS_ID,
        T.TASK_MAN_ID,
        T.TASK_TOP_ID,
        T.TASK_REG_ID,
        T.TASK_TITLE,
        T.TASK_REG_DT,
        T.TASK_DDLINE_DT,
        T.TASK_MOD_DT,
        T.TASK_CN,
        T.TASK_RQRD,
        T.TASK_EST_TIME,
        T.TASK_COMP_DT,
        P.PRO_NAME
    FROM 
        TASK T
    JOIN 
        PROJECT P ON T.PRO_ID = P.PRO_ID
)
-- 프로젝트ID(PRO_ID), 상위일감(TASK_TOP_ID), 일감ID(TASK_ID), 일감상태ID(TS_ID),일감상태명(TPS_NAME),
-- 일감제목(TASK_TITLE), 담당자(TASK_MAN_ID), 일감처리ID(TPS_ID),일감처리명(TPS_NAME), 
-- 일감등록일(TASK_REG_DT),일감마감일(TASK_DDLINE_DT), 일감수정일(TASK_MOD_DT),일감등록자ID(TASK_REG_ID),일감내용(TASK_CN),일감처리 진행률(TPS_ING)
SELECT 
    TaskProject.ROWNUM
    ,TaskProject.PRO_ID
    ,TaskProject.TASK_TOP_ID
    ,TaskProject.TASK_ID
    ,TS.TS_NAME
    ,TaskProject.TASK_TITLE
    ,TSP.TPS_ING
    ,TSP.TPS_NAME
    ,TaskProject.TASK_MAN_ID
    ,TaskProject.TASK_REG_DT
    ,TaskProject.TASK_DDLINE_DT
    ,TaskProject.TASK_MOD_DT
    ,TaskProject.TASK_CN

FROM TaskProject
JOIN TASK_STATUS TS ON (TaskProject.TS_ID= TS.TS_ID)
JOIN TASK_PROCESS_STATUS TSP ON ( TaskProject.TPS_ID = TSP.TPS_ID );




--rownum은 CTE(common table expression) 또는 서브쿼리 외부에서 사용할 수 없기때문에 별칭을 만든 후에 외부에서 사용해야함
    WITH TaskProject AS (
        SELECT 
            ROWNUM AS RNUM ,
            T.TASK_ID,
            T.TS_ID, 
            T.PRO_ID,
            T.TPS_ID,
            T.TASK_MAN_ID,
            T.TASK_TOP_ID,
            T.TASK_REG_ID,
            T.TASK_TITLE,
            T.TASK_REG_DT,
            T.TASK_DDLINE_DT,
            T.TASK_MOD_DT,
            T.TASK_CN,
            T.TASK_RQRD,
            T.TASK_EST_TIME,
            T.TASK_COMP_DT,
            P.PRO_NAME
        FROM 
            TASK T
        JOIN 
            PROJECT P ON T.PRO_ID = P.PRO_ID
    ),
    totalRecord AS (
        SELECT 
            TaskProject.RNUM,
            TaskProject.PRO_ID,
            TaskProject.PRO_NAME,
            TaskProject.TASK_TOP_ID,
            TaskProject.TASK_ID,
            TS.TS_NAME,
            TaskProject.TASK_TITLE,
            TSP.TPS_ING,
            TSP.TPS_NAME,
            TaskProject.TASK_MAN_ID,
            TaskProject.TASK_REG_DT,
            TaskProject.TASK_DDLINE_DT,
            TaskProject.TASK_MOD_DT,
            TaskProject.TASK_CN
        FROM TaskProject
        JOIN TASK_STATUS TS ON TaskProject.TS_ID = TS.TS_ID
        JOIN TASK_PROCESS_STATUS TSP ON TaskProject.TPS_ID = TSP.TPS_ID 
    )
    SELECT count(*) FROM totalRecord;

-- common dao : 일감 상태, 진행상태
-- 일감 상태
SELECT TS_ID, TS_NAME FROM TASK_STATUS;

-- 일감진행상태
SELECT 
TPS_ID
,TPS_NAME
,TPS_ING
,TPS_DESC
FROM TASK_PROCESS_STATUS;
