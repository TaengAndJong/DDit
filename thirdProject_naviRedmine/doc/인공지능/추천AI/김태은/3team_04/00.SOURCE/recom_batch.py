from day01.daofoods import DaoFoods

# 저장된 데이터 목록조회
dao=DaoFoods();
list = dao.xyTrainSelectList()
print(list, len(list))

for i in list:
    print(i)
    rank=""
    dao.insertFoodRecom(i[0], i[1], i[2], i[3],rank)
