import cx_Oracle 
import numpy as np

class DaoFoods:
    def __init__(self):
        self.conn = cx_Oracle.connect('TEAM3_202308F/java@112.220.114.130:1521/xe')
        self.cur = self.conn.cursor()
    
    #기존 오늘의 날씨 테이블 조회
    def selectWeather(self):
        sql = """
              SELECT 
              TRIM(WEATHER_ID)
              ,WEATHER_TYPE
              ,DUST
              ,UV
              ,TEMP
               FROM WEATHER
          """
        self.cur.execute(sql)
        list = self.cur.fetchall()
        return list
    
    #배치파일 실행시 시간별로 오늘의 날씨에 대한 정보가 갱신되게할 업데이트쿼리
    def updateWeather(self, weathertype, dust, uv, temp):

        if "맑음" in weathertype:
            weatherid = 0
        elif "흐림" in weathertype:
            weatherid = 1
        elif "구름많음" in weathertype:
            weatherid = 2
        elif "비" in weathertype:
            weatherid = 3
        elif "눈" in weathertype:
            weatherid = 4
        else:
            weatherid = 5
            
      
            
        sql = """
        INSERT INTO WEATHER (
          WEATHER_ID,
          WEATHER_TYPE,
          DUST,
          UV,
          TEMP
        ) VALUES (
            :weatherid
            , :weathertype
            , :dust
            , :uv
            , :temp
        )
        """
        self.cur.execute(sql, {'weatherid': weatherid, 'weathertype': weathertype, 'dust': dust, 'uv': uv, 'temp': temp})
        self.conn.commit()
        print(self.cur.rowcount)
        return self.cur.rowcount

    #x_train emp 와 weather 조인하기

    
    def xyTrainSelectList(self):
        sql =   """
               SELECT 
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
        """
        self.cur.execute(sql)
        list = self.cur.fetchall()
        list = np.array([[float(cell) for cell in row] for row in list])
     
        return list
    
    
    # PMS 사원의 조회를 통해 모인 데이터  xyTrain을 기반으로 데이터 모델을 만들어 foodRecome에 데이터 추가하기
    def insertFoodRecom(self, weather, food, age, gen,rank):
        sql =   """
        INSERT INTO FOOD_RECOM (
                WEATHER_ID
                ,FOOD_ID
                ,AGE
                ,GEN
                ,RANK
                
            ) VALUES (
                :weather
              , :food
              , :age
              , :gen
              , :rank
            )
        """
        self.cur.execute(sql, {'weather': weather, 'food':food,'age':age ,'gen':gen,'rank':rank})
        self.conn.commit()
        print( self.cur.rowcount)
        return self.cur.rowcount
        
    
    #랭크를 세어줄 cnt 
    
    #음식아이디로 조회된 음식의 레코드 수를 세어 랭킹올리기?
    def selectFoodRecomCnt(self,id):
        sql =   f"""
           SELECT  COUNT(*) FROM FOODRECOM
           WHERE FOOD_ID = '{id}' 
          """  
        self.cur.execute(sql)
        rank= self.cur.fetchone()
        return rank[0];
    

    def ytrainCnt(self):
        sql="SELECT COUNT(*) FROM FOOD"
        self.cur.execute(sql)
        cnt=self.cur.fetchone()
        return cnt[0]
    
    
    def deleteRecom(self):
        sql = """
            DELETE FROM FOOD_RECOM
        """
        self.cur.execute(sql)
        self.conn.commit()
        return self.cur.rowcount

    
    def __del__(self):
        self.cur.close()
        self.conn.close()
            
        
if __name__ == '__main__':
    dao = DaoFoods()
    selectWeather = dao.selectWeather()
    #x_trains = dao.x_trainSelectList()
    xy_trains = dao.xyTrainSelectList()
    print(xy_trains)
    #weatherList = dao.updateWeather('눈','-0.5','나쁨','높음')
    # x_train = de.selectList()
    # y_train = de.selectLabeList()
    # xyLabellist = de.selectXYLabelList();
    # cnt = de.selectLabeList()
    # imgurl=de.selectImgUrlList("1");
    # name=de.selectRecomName("1");
    # selectFoodList = de.selectFoodList();
    # list=de.selectNewsCgList();
    
