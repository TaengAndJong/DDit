from bs4 import BeautifulSoup
from pprint import pprint
import requests
from day01.daofoods import DaoFoods

url = 'https://search.naver.com/search.naver?query=날씨'

response = requests.get(url)

if response.status_code == 200:
    html = response.text
    soup = BeautifulSoup(html, 'html.parser')
    weather = soup.select_one('#main_pack > section.sc_new.cs_weather_new._cs_weather > div > div:nth-child(1) > div.content_wrap > div.open > div:nth-child(1) > div > div.weather_info > div > div._today > div.temperature_info > p > span.weather.before_slash')
    temp = soup.select_one('#main_pack > section.sc_new.cs_weather_new._cs_weather > div > div:nth-child(1) > div.content_wrap > div.open > div:nth-child(1) > div > div.weather_info > div > div._today > div.weather_graphic > div.temperature_text > strong')
    dust_ul = soup.select_one('#main_pack > section.sc_new.cs_weather_new._cs_weather > div > div:nth-child(1) > div.content_wrap > div.open > div:nth-child(1) > div > div.weather_info > div > div.report_card_wrap > ul')
  
    weather = weather.text
    temp=temp.text
    dust_title = dust_ul.find_all("li")[0].select_one("strong").text
    dust_status= dust_ul.find_all("li")[0].select_one("span").text
    uv_title=dust_ul.find_all("li")[2].select_one("strong").text
    uv_status=dust_ul.find_all("li")[2].select_one("span").text
    
    #x_train- 1)오늘날씨
    print(weather, end=" ") 
    print(temp, end=" ")
    print(dust_title, end=" ")
    print(dust_status, end=" ")
    print(uv_title, end=" ")
    print(uv_status, end=" ")
    
    dao= DaoFoods();
    today_weather= dao.updateWeather(weather, dust_status, uv_status, temp)
    print(today_weather)

else: 
    print(response.status_code)
    
#네이버날씨에서 오늘의 날씨를 크롤링 한 후에 오늘의 날씨 데이터베이스에 해당컬럼 날씨라벨, 날씨종류, 미세먼지, 자외선, 온도를 
#insert 시켜준다.  
