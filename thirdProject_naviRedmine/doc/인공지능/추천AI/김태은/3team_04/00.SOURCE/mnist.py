import tensorflow as tf
import numpy as np
from day01.daofoods import DaoFoods

# print(tf.__version__)
dao=DaoFoods()
print("dao",dao)
list=dao.xyTrainSelectList();
cnt= dao.deleteRecom()#경우의 수를 뽑기위한 ytrain 총 카운트
print("list",list)
print("cnt",cnt)
# for idx, i in enumerate(list):
#     print(idx,i[idx])

if cnt>0:
# xtrain ytrain을 통합한 테이블에서 각긱 배열로 받아서 분리해주기
    cnt= dao.ytrainCnt()#경우의 수를 뽑기위한 ytrain 총 카운트
    x_train =[]
    for i in list:
        x = [i[0],i[2],i[3]]
        x_train.append(x)
        #x_train=np.array(x_train)
        print("x_train",x_train)
    x_train=np.array(x_train)
    
    y_train =[] 
    for i in list:
        y = [i[1]] #foodID
        y_train.append(y)
        #y_train=np.array(y_train)
        print("y_train",y_train)
        
    
    y_train=np.array(y_train)   
    print(x_train,len(x_train))
    print(y_train,len(y_train))
    
    
    model = tf.keras.models.Sequential([
        tf.keras.layers.Flatten(input_shape=(3,)),
        tf.keras.layers.Dense(512, activation=tf.nn.relu),
        tf.keras.layers.Dense(512, activation=tf.nn.relu),
        tf.keras.layers.Dense(cnt, activation=tf.nn.softmax)
    ])
    
    model.compile(optimizer='adam',
                      loss='sparse_categorical_crossentropy',
                      metrics=['accuracy'])
        
    model.fit(x_train, y_train, epochs=30)
    model.summary()
    model.save('food_recom.h5')
    
    arr=[]
    for i in range(5):
        for j in range(5):
            for k in range(2):
                arr.append([i, j, k])
                print("i,j,k",i,j,k)
    
    print("x_train에 대한 총 경우의 수를 셀 수 있다." ,len(arr))
                
    newarr=[]
    for i in arr:
        pred = model.predict(np.array([[i[0], i[1], i[2]]]).astype(float))
        print(i)
        idx1=np.argmax(pred[0])# 경우에 수에 따른 음식 추천 예측결과
        pred[0][idx1]=0
        idx2=np.argmax(pred[0])
        pred[0][idx2]=0
        idx3=np.argmax(pred[0])
        
        #Food_RECOM 테이블에 맞게 순서도 맞춰줘야 함 
        a1=[str(i[0]),str(idx1),str(i[1]),str(i[2]),"1"]
        
        newarr.append(a1)
        a2=[str(i[0]),str(idx2),str(i[1]),str(i[2]),"2"]
        newarr.append(a2)
        a3=[str(i[0]),str(idx3),str(i[1]),str(i[2]),"3"]
        newarr.append(a3)
        
    print(newarr)
    cnt=0;
    for i in newarr:
        j=dao.insertFoodRecom(str(i[0]), str(i[1]), str(i[2]), str(i[3]), str(i[4]))
        cnt=cnt+j
    