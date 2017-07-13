# 데이터 셋 조회
# 데이터 셋 전체를 볼 수 있는 함수 : print(), View()
dataset <- read.csv(file.choose(), header=T) # Part-II dataset.csv
dataset
View(dataset) # 별도의 데이터 뷰화면
print(dataset) # console 화면
dataset
head(dataset) # 앞부분 6개
tail(dataset) # 뒷부분 6개
str(dataset) # 7개 변수, 300개 관측치
names(dataset)
#               척도      범위      설명
# "resident" :  명목      1~5       거주시
# "gender"   :  명목      1,2       성별  
# "job"      :  명목      1~3       직업
# "age"      :  비율      20~69     나이
# "position" :  서열      1~5       직위
# "price"    :  비율      2.1~7.9   구매금액
# "survey"   :  등간      1~5       만족도

attributes(dataset)

dataset$age
length(dataset$age) # 300
x <- dataset$age
y <- dataset$price
plot(y~x)  # 연령과 구매금액의 산점도이나 결측치, 극단값 때문에 효력이 없음.
plot(y)

# 컬럼명으로 해당변수 데이터 조회
dataset["age"]
dataset["gender"]

# index로 조회
names(dataset)
dataset[1] # 첫번째 index : resident
dataset[,1] # 첫번째 열 index : resident
dataset[1,] # 첫번째 관측치의 모든 값

# 데이터 셋에서 2개 이상 컬럼(변수) 조회
dataset[c(1:2)] # resident, gender
dataset[c("age","price")]
dataset[c(1:4,7)] # 1~4열 컬럼과 7열 컬럼

# 특정 행/열 조회
dataset[1,1] # 1행 1열 값
dataset[c(1:3,5),] # 1~3행, 5행 값
dataset[c(3:5),c(4:7,2)] # 3~5행, 4~7, 2열 값
dataset[-c(1:10, 21:300),] # 1~10행, 21~300행을 제외한 나머지 행 값

# 결측치 확인
summary(dataset$price) # NA's 30 : 결측치가 30개 있다.
sum(dataset$price) # NA. 결측치가 있으면 산술이 적용 안된다.
summary(dataset)

# 결측치 제거
# na.rm=T 사용
sum(dataset$price, na.rm=T)
mean(dataset$price,na.rm=T)

# na.omit() 사용
price2 <- na.omit(dataset$price) # price변수에 있는 모든 결측치 제
sum(price2)
length(price2) # 결측치 30개 제거

# 결측치 대체
# 결측치를 제거하지 않고 0이나 평균으로 대체
dataset$price2 <- ifelse(is.na(dataset$price), 0, dataset$price) # 결측치를 0으로 대체
summary(dataset$price2)

# 결측치를 평균으로 대체
dataset$price3 <- ifelse(is.na(dataset$price), 
                         round(mean(dataset$price, na.rm=T),2), dataset$price)
summary(dataset$price3)
summary(dataset$price2)
summary(dataset$price)

# 극단치 처리
# 극단치 : 변수의 분포에서 비정상적으로 분포를 벗어난 값

# 범주형 변수 극단치 처리
gender_tb <- table(dataset$gender) # 성별 범주를 1,2로 지정했는데 0과 5가 존재(극단치)
pie(gender_tb) # piechart로 확인하기

# subset() 함수를 통한 데이터 정제
# subset : 변수 <- subset(data, 조건식)
dataset <- subset(dataset, gender==1 | gender==2)
gender_tb # 0과 5값이 사라진 걸 확인
pie(gender_tb, col=c("red", "blue"))

# 연속형 변수의 극단치 처리
dataset$price
plot(dataset$price) 
summary(dataset$price) # -457~675 극단치 존재

# price변수 정제 (기존 범위 2.1~7.9)
dataset <- subset(dataset, dataset$price >=2 & dataset$price<=8)
length(dataset$price)
stem(dataset$price) # 줄기잎 그림(세부가격은 잎으로 표현)
hist(dataset$price)
plot(dataset$price) 

# age변수 정제
summary(dataset$age) # 결측치 16개 존재, 최소값 20, 최대값 69
dataset <- subset(dataset, dataset$age>=20 & dataset$age<=69)
summary(dataset$age)
boxplot(dataset$age) # boxplot 평균연령 : 40대 중반

# 가독성을 위한 코딩변경

