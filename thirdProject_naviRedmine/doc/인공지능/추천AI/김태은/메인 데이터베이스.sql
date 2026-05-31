SELECT *
FROM (
    SELECT
        bp_id,
        bp_title,
        bp_reg_dt
    FROM
        board_post
    ORDER BY
        bp_reg_dt DESC
)
WHERE ROWNUM <= 4;


--전체게시판 대상

		SELECT  A.* FROM (
            SELECT
            bp_id
            , bp_title
            , bp_reg_dt
            , bp_cnt
            , COMMON.CM_NAME as bp_ntc_name
            FROM
            board_post
            JOIN COMMON ON
            (BOARD_POST.BP_NTC_ID=COMMON.CM_ID)
            order by bp_reg_dt desc
            ) A 
        
WHERE ROWNUM <= 4

-- 메인프로젝트

SELECT COUNT(*)
FROM (
    SELECT project.pro_id
    FROM project
    INNER JOIN team ON (project.pro_id = team.pro_id)
    INNER JOIN emp ON (team.emp_id = emp.emp_id)
    INNER JOIN common ON (project.pro_st_id = common.cm_id) 
    LEFT OUTER JOIN wiki ON (project.pro_Id = wiki.pro_Id)
    ORDER BY pro_reg_dt DESC 
) A
    
-- 모든 프로젝트조회
SELECT
   pro_id,
    pro_reg_dt
   
FROM
project 
ORDER BY  pro_reg_dt DESC;

--메인 그래프 테스트 데이터
-- 2023년 1월 데이터 추가
-- 2023년 1월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00016', 'PS001', '메인그래프 개수 테스트니다.1', 'Description1', TIMESTAMP '2024-04-29 00:00:00', TIMESTAMP '2023-01-31 23:59:59', NULL, NULL, NULL);

-- 2023년 2월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00017', 'PS002', '메인그래프 개수스트 데', 'Description2', TIMESTAMP '2024-04-29 00:00:00', TIMESTAMP '2023-02-28 23:59:59', NULL, NULL, NULL);

-- 2023년 4월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00018', 'PS0003', '메인그래프 ', 'Description3', TIMESTAMP '2023-03-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);

-- 2023년 5월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00019', 'PS0001', '메인그래프 개수', 'Description1', TIMESTAMP '2023-04-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);

-- 2023년 6월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00020', 'PS0002', '메인그래프 개수 테스트 데이터입니2', 'Description2', TIMESTAMP '2023-05-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);

-- 2023년 7월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00030', 'PS0003', '메인그래프 개수 테스트 데이터입니다3', 'Description3', TIMESTAMP '2023-06-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);

-- 2023년 8월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00031', 'PS0002', '메인그래프 개수 테스트 데이터입니다2', 'Description2', TIMESTAMP '2023-07-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);

-- 2023년 9월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00032', 'PS0003', '메인그래프 개수 테스트 데이터입니다.3', 'Description3', TIMESTAMP '2023-08-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);

-- 2023년 10월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00033', 'PS0001', '메인그래프 개수 테스트 데이터입니다.1', 'Description1', TIMESTAMP '2023-09-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);

-- 2023년 11월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00034', 'PS0002', '메인그래프 개수 테스트 데이터입니다2', 'Description2', TIMESTAMP '2023-10-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);

-- 2023년 12월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00035', 'PS0003', '메인그래프 개수 테스트 데이터입니다3', 'Description3', TIMESTAMP '2023-11-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);

-- 2024년 01월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00036', 'PS0003', '메인그래프 개수 테스트 데이터입니다3', 'Description3', TIMESTAMP '2023-12-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);

-- 2024년 01월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00037', 'PS0001', '메인그래프 개수 테스트 데이터입니다3', 'Description3', TIMESTAMP '2024-01-01 00:00:00', TIMESTAMP '2024-04-29 23:59:59', NULL, NULL, NULL);


-- 2024년 01월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00039', 'PS0001', '메인그래프 개수 테스트 데이터입니다1', 'Description3', TIMESTAMP '2023-05-01 00:00:00', TIMESTAMP '2024-04-29 20:00:00', NULL, NULL, NULL);

-- 2024년 01월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00040', 'PS0002', '메인그래프 개수 테스트 데이터입니다1', 'Description3', TIMESTAMP '2023-04-01 00:00:00', TIMESTAMP '2024-04-29 20:00:00', NULL, NULL, NULL);

-- 2024년 01월 데이터 추가
INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00041', 'PS0003', '메인그래프 개수 테스트 데이터입니다1', 'Description3', TIMESTAMP '2023-04-01 00:00:00', TIMESTAMP '2024-04-29 20:00:00', NULL, NULL, NULL);

INSERT INTO PROJECT (PRO_ID, PRO_ST_ID, PRO_NAME, PRO_DESC, PRO_REG_DT, PRO_DDLINE_EX, PRO_DDLINE_DT, PRO_DDLINE_YN, PRO_DEL_YN)
VALUES ('P00042', 'PS0003', '메인그래프 개수 테스트 데이터입니다1', 'Description3', TIMESTAMP '2023-03-01 00:00:00', TIMESTAMP '2024-04-29 20:00:00', NULL, NULL, NULL);
commit;


commit;

commit;

	 SELECT
	      	PRO_ID,
		    PRO_ST_ID,
		    PRO_NAME,
		    PRO_DESC,
		    PRO_REG_DT,
		    PRO_DDLINE_EX,
		    PRO_DDLINE_DT,
		    PRO_DDLINE_YN,
		    PRO_DEL_YN
		FROM project
        where PRO_DEL_YN IS NULL
		ORDER by pro_reg_dt desc 
        
 SELECT
      	PRO_ID,
	    PRO_ST_ID,
	    PRO_NAME,
	    PRO_DESC,
	    PRO_REG_DT,
	    PRO_DDLINE_EX,
	    PRO_DDLINE_DT,
	    PRO_DDLINE_YN,
	    PRO_DEL_YN
	FROM PROJECT
       where PRO_DEL_YN IS NULL
	ORDER by pro_reg_dt desc ;
    
    SELECT
		bp_id
		, bp_title
		,
		bp_reg_dt
		, board_post.bp_ntc_id
		, bp_mod_dt
		, bp_cnt
		, bp_cn
		, COMMON.CM_NAME
		as bp_ntc_name
		FROM
		board_post
		JOIN COMMON ON
		(BOARD_POST.BP_NTC_ID=COMMON.CM_ID)
		WHERE
		BRD_ID like 'BN%'
		AND BP_ID = 'B00127';
        SELECT
				    bp_id
				  , EMP.emp_name
				  , bp_mod_id
				  , bp_title
				  , bp_cn
				  , bp_reg_dt
				  , bp_cnt
				  , bp_mod_dt
				FROM
				    board_post
				JOIN
				    EMP ON(board_post.emp_id = emp.emp_id)
				WHERE BRD_ID = 'BN0003'
				AND BP_ID = 'B00128'