SELECT * FROM RECOM_CATEGORY;
SELECT * FROM FOOD;
SELECT * FROM FOOD_RECOM;
SELECT * FROM FOOD_AREA;


---- 어떤 사원이 어떤 지역 조회 했는가에 대한 데이터 조회 
---- x_train은 연령,성별,대전행정구
select 
CASE 
        WHEN emp.emp_age < 30 THEN '0'
        WHEN emp.emp_age < 40 THEN '1'
        WHEN emp.emp_age < 50 THEN '2'
        WHEN emp.emp_age < 60 THEN '3'
        ELSE '4'
END AS 연령대
,
CASE 
        WHEN emp.emp_gen  = 'F' THEN '0'
        WHEN emp.emp_gen  = 'M' THEN '1'
END AS 성별
,
CASE 
        WHEN emp.emp_addr LIKE '%동구%' THEN '0'
        WHEN emp.emp_addr LIKE '%중구%' THEN '1'
        WHEN emp.emp_addr LIKE '%서구%' THEN '2'
        WHEN emp.emp_addr LIKE '%유성구%' THEN '3'
        WHEN emp.emp_addr LIKE '%대덕구%' THEN '4'
        ELSE '5'
END AS 대전행정구
from food_views join emp on(food_views.emp_id=emp.emp_id)
ORDER BY food_views.emp_id;

-- y_train
SELECT COUNT(*) FROM FOOD;



