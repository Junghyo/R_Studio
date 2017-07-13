# plyr package 활용
# plyr : 두개 이상의 data.frame을 대상으로 key값을 이용하여 merge하거나 
#        집단변수를 기준으로 data.frame의 변수에 함수를 적용하여 요약집계 결과 제공

# 데이터 병합하기
# 단계 1 : plyr package 설치
install.packages("plyr")
require(plyr)
# 단계 2 : 병합할 데이터프레임 만들기
# id 컬럼이 공통으로 포함된 두 개의 data.frame 생성(id 값들이 동일)
x <- data.frame(id=c(1:5), height=c(160,171,173,162,165))
y <- data.frame(id=c(5,4,1,3,2), weight=c(55,73,60,57,80))
# 단계 3 : join() 함수 이용 데이터 결합
# merge 방식
example(merge)
merge <- merge(x, y, by.x="id", by.y="id")
merge
# join 방식
help(join)
join <- join(x, y, by="id")
join

# 왼쪽(left) join
x <- data.frame(id=c(1,2,3,4,6), height=c(160,171,173,162,180))
y <- data.frame(id=c(5,4,1,3,2), weight=c(55,73,60,57,80))
merge(x,y, by="id") # merge는 id값이 다른 경우는 제외하고 합침
join(x,y, by="id", type="left") # data.frame x의 id값을 기준으로 join
join(x,y) # default가 자동적으로 left join

# 오른쪽(right) join
join(x, y, by="id", type="right")

# 내부(inner) join
join(x, y, type="inner") # 동일한 id값이 있는 데이터만 출력됨(merge와 동일)

# 전체(full) join
join(x, y, type="full") # join하는 vector에 해당 데이터값이 없으면 NA로 출력

# 두개의 key로 병합하기
x <- data.frame(key1=c(1,1,2,2,3), key2=c("a","b","c","d","e"), val1=seq(10,50,10))
y <- data.frame(key1=c(3,2,2,1,1), key2=c("e","d","c","b","a"), val2=seq(500,100,-100))
join(x,y,by=c("key1","key2"))
merge(x,y, by=c("key1","key2"))
# merge하고 join하고 동일하게 나온다

# 그룹별 기술통계량 구하기
# 집단변수를 대상으로 그룹별 기술통계치 구하기
# 집단변수 : 성별과 같이 남자 또는 여자의 범주를 갖는 변수

# (1) tapply() : tapply(data, 집단변수, 함수)
# iris 데이터셋으로 tapply() 함수 적용
# 단계 1 : iris 데이터셋 구조보기
head(iris)
str(iris) #5개 변수, 150개 관측치
names(iris) # "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species" 
mode(iris); class(iris) # list, data.frame
levels(iris$Species) # "setosa" "versicolor" "virginica" 
unique(iris$Species) # "setosa" "versicolor" "virginica" 
# iris 데이터는 꽃의 종류별(3가지)로 각각 50개의 관측치로 구성

# 단계 2 : 집단변수로 통계치 구하기
# 꽃의 종류별 꽃받침 길이 평균, 표준편차 구하기
tapply(iris$Sepal.Length, iris$Species, mean) # 평균
tapply(iris$Sepal.Length, iris$Species, sd) # 표준편차

# ddply() : ddply(data, .(집단변수), 요약집계, 컬럼명=함수(변수))
# 꽃의 종류별 꽃받침 길이의 평균 구하기
avg_df <- ddply(iris, .(Species), summarize, avg=mean(Sepal.Length))
str(avg_df) # 2개의 변수(종, 평균), 3개의 관측치

# 꽃의 종류별 여러 개의 함수 적용하기
summary_iris <- ddply(iris, .(Species), summarize, 
                      mean=mean(Sepal.Length),
                      sd=sd(Sepal.Length),
                      max=max(Sepal.Length),
                      min=min(Sepal.Length))
summary_iris

# 반올림 처리
# 여러방법이있지만 gather, spread로 처리해봄
install.packages("tidyr")
require(tidyr)
summary_iris 
iris_gather<-gather(summary_iris,key,value,2:5)
iris_gather$value <- round(iris_gather$value,2)
summary_iris2 <- spread(iris_gather,key,value)
summary_iris2

# dplyr packag 활용
require(dplyr)
tbl_df(iris) # 데이터 셋에서 콘솔 창 크기 만큼 추출
filter(iris, iris$Petal.Width>2) # 해당 조건에 맞는 데이터 추출 가능
select(iris, Sepal.Length, Sepal.Width) # 컬럼 선택
mutate() # 데이터 셋에 새로운 컬럼 추가
arrange() # 데이터 셋을 특정 컬럼으로 정렬
summarise(iris,iris$Species[1],mean=mean(iris$Sepal.Length)) # 특정 컬럼에 대한 요약

# 콘솔 창의 크기에 맞게 데이터 추출
install.packages("hflights")
library(hflights)
head(hflights)
str(hflights) # 21개 변수, 227496 관측치
View(head(hflights))
mode(hflights); class(hflights) # list, data.frame
hflights_df <- tbl_df(hflights)
hflights_df

# 조건에 맞는 데이터 filtering
# 1월 2일 데이터 추출
filter(hflights_df, hflights_df$Month==1 & hflights_df$DayofMonth==2)
# 1월 혹은 2월 데이터 추출
filter(hflights_df, hflights_df$Month==1 | hflights_df$Month==2)

# 컬럼으로 데이터 정렬
# arrange : arrange(data, 컬럼1, desc(컬럼2), ...)
# 년, 월, 출발시간, 도착시간 순으로 오름차순 정렬
names(hflights_df) # 컬럼명 보기
arrange(hflights_df, Year, Month, DepTime, ArrTime)
# 도착시간 내림차순 정렬
arrange(hflights_df, Year, Month, desc(DepTime), ArrTime)

# 컬럼으로 데이터 검색
# select : select(data, 컬럼1, 컬럼2,...)
# 년, 월, 출발시간, 도착시간 검색
select(hflights_df, Year, Month, DepTime, ArrTime)
# 컬럼의 범위 지정
names(hflights_df)
select(hflights_df, Year:ArrTime)
# Year~ArrTime 컬럼을 제외한 나머지를 보고 싶을 경우
select(hflights_df, -(Year:ArrTime))

# 데이터 셋에 컬럼 추가
# mutate : mutate(data, 컬럼명1=수식2, 컬럼명2=수식2,...)
# 출발지연시간과 도착지연시간과의 차이를 계산하는 컬럼 추가
hflights_add <- mutate(hflights_df, gain=ArrDelay-DepDelay, gain_per_hour=gain/(AirTime/60))
# 추가된 컬럼 보기
select(hflights_add, Year, Month, ArrDelay, DepDelay, gain, gain_per_hour)

# 요약 통계치 계산
# summarise = summarise(data, 추가할컬럼명=함수(컬럼명),...)
# 비행시간 평균 계산하기
summarise(hflights_df, cnt=n(),avgAirTime=mean(AirTime, na.rm=T))
# n() : row값 리턴
# 도착시간의 표준편차와 분산 계산하기
summarise(hflights_df, sd=sd(AirTime, na.rm=T), var=var(AirTime, na.rm=T))

# 집단변수 대상 그룹화
# grounp_by : group_by(data, 집단변수)
str(iris) # 요인이 species 3레벨
species <- group_by(iris, Species)
species
str(species)
mode(species); class(species) # list, grouped_df/tbl_df/tbl/data.frame

# 항공기별로 비행편수 구하기
# 단계 1 : 항공기별로 그룹화하기
names(hflights_df)
planes <- group_by(hflights_df, TailNum)
planes

# 단계 2 : 항공기별 기술통계량
planes_info <- summarise(planes, count=n(),
                         mean_dist=mean(Distance, na.rm=T),
                         mean_delay=mean(ArrDelay, na.rm=T))
planes_info

# 단계 3 : 기술통계량 변수에 조건 지겅
result <- filter(planes_info, count>35, mean_dist<1500)
result

# 단계 4: result에서 mean_dist와 mean_delay 변수 모두 1이상인 경우
filter(result, mean_dist>1 & mean_delay>1)
plot(result$mean_delay~result$mean_dist) # 산점도
abline(result_lm, col="red") # 회귀선
# 회귀식
result_lm <- lm(result$mean_delay~result$mean_dist)
# 상관분석
result_cor <- cor.test(result$mean_delay,result$mean_dist)
result_cor
# 회귀분석
summary(result_lm)

# reshape package 활용
# 데이터 셋의 구성이 구분변수에 의해 측정변수가 분류된 경우, 데이터 셋의 모양을 변경하는데
# 유용한 package
# 구분변수 : 데이터 셋에서 1개 이상으로 분류되는 집단변수
# 측정변수 : 구분변수에 의해 분류되는 변수

# 컬럼명 변경 : rename() 이용
# 단계 1 : package 설치
install.packages("reshape")
library(reshape)
# 단계 2 : 실습 데이터 셋 가져오기(Part-II의 reshape.csv)
data <- read.csv(file.choose(), header=F)
head(data)
str(data) # 4개 변수, 150개 관측치
mode(data); class(data) # list, data.frame
# 단계 3 : 컬럼명 변경
data <- rename(data, c(V1="total", V2="num2", V3="num3", V4="num4"))
head(data)

# 긴 형식을 넓은 형식으로 변경
help(reshape)
reshape(data,
        varying = "반복되는 측정 색인",
        v.names = "반복되는 측정 값",
        timevar = "반복되는 측정 시간",
        idvar = "1개 이상의 값으로 분류되는 변수", ids = 1:NROW(data),
        times = seq_along(varying[[1]]),
        driection = "wide/long")

# Indometh 데이터 셋 보기
data("Indometh")
head(Indometh)
str(Indometh) # 3개 변수, 66개 관측치
names(Indometh) # 컬럼명 : subject, time, conc
mode(Indometh); class(Indometh) # list, nfnGroupedData/nfGroupedData/groupedData/data.frame
wide <- reshape(Indometh, v.names="conc", timevar="time", 
                idvar="Subject", direction="wide")
wide
plot(Indometh$conc~Indometh$time, col=Indometh$Subject)
help("Indometh")
# 기준변수(timevar="time", idvar="Subject")에 의해서 관측변수(v.names="conc)가
# 넓은 형식으로 구조가 변경된다.
# 실험대상1을 기준으로 약물투여시간 0.25~8 동안 약물투여 농도를 나타내고 있다.

# 넓은 형식을 긴 형식으로 변경
reshape(wide, direction="long")

# varying 속성으로 색인 지정
long <- reshape(wide, idvar="Subject", varying=2:12, v.names="conc", direction="long")
str(long) # 3개 변수, 66개 관측치
long
# 넓은 형식에서 행 변수(Subject) 값과 컬럼 순서번호(2:12)의 조합으로 긴형식으로 변경

# melt() 함수를 이용하여 smiths 데이터 셋 구조 변경
# melt : melt(data, id="기준변수", measured="측정변수")
# 단계 1 : smiths 데이터 셋 확인
smiths
str(smiths)  # 5개의 변수, 2개의 관측치
mode(smiths); class(smiths) # list, data.frame
# 단계 2 : 기준변수(subject, time)을 이용 측정변수 분류
# 다음 R 코드는 동일한 결과를 나타낸다.
melt(smiths, id="subject")
melt(smiths, id="subject", measured=c("age"))
melt(smiths, id="subject", measured=c("age", "height", "weight"))
melt(smiths, id="time") # Error : 요인(factor)이 아니기 때문
# 기준변수를 subject과 time으로
melt(smiths, id=c("subject", "time"))
# 기준변수를 subject, time, weight로
melt(smiths, id=c("subject", "time", "weight"))
# 전부다 기준변수
melt(smiths, id=c(1:5)) == smiths # 동일
# NA 관측치 제거
melt(smiths, id=1, na.rm=T)
melt(smiths, id=c(1:2), na.rm=T) 
# NA가 있는 경우는 제외하고 나온다

# 측정변수에 집합함수 적용
# cast : cast(data, formula=...~variable, fun.aggregate=NULL,...)
help(cast)
# data : melt() 함수에 의해 생성된 데이터 셋
# formula : (col_var_1 + col_var_2 ~ row_var_1 + row_var_2)
# variable : 측정변수
# fun.aggregate : 집합함수

# 넓은 형식을 긴 형식으로 변경
# 단계 1 : melt()로 생성된 data.frame을 이용하여 데이터의 구조 변경
smiths
smiths_m <- melt(smiths, id=c(1:2))
smiths_m

# 단계 2 : 기준변수를 이용하여 긴 형식을 넓은 형식으로 변경
cast(smiths_m, subject+time~variable)
cast(smiths_m, ...~variable) # 기준변수를 ...로 생략해도 동일하다
# 기존 데이터 셋(smiths)과 동일

# 측정변수에 집합변수 적용
# 단계 1 : melt() 함수 이용 데이터 셋 생성
str(Indometh)
Indometh
long <- melt(Indometh, id=c("Subject", "time"))
long
# 단계 2 : 집단함수를 이용하여 통계량 계산
cast(long, Subject~variable, sum)
tapply(long$value, long$Subject, sum)
tapply(Indometh$conc, Indometh$Subject, sum)
# 동일

# 단계 3 : 평균과 범위 기술통계량 계산
# 평균
cast(long, Subject~variable, mean)
tapply(long$value, long$Subject, mean)
# 범위
cast(long, Subject~variable, range)
tapply(long$value, long$Subject, range)

# reshape2 package 활용
# dcast()로 긴 형식을 넓은 형식으로 변경
install.packages("reshape2")
library(reshape2)
library(dplyr)
data <- read.csv(file.choose()) # Part-II data.csv
tbl_df(data)
str(data) # 3개 변수, 22개 관측치
mode(data); class(data) # list, data.frame
# dcast : dcast(data, 앞변수~뒤변수, 적용함수)
filter(data,Customer_ID==1)
filter(data,Customer_ID==2)
filter(data,Customer_ID==3)
wide <- dcast(data, Customer_ID~Date, sum)
wide
# Using Buy as value column: use value.var to override. : 정리 대상 변수(Buy)

# 파일 저장 및 읽기
write.csv(wide, "C:/R_Studio/Rscript/chapter/chapter06/data_wide.csv", row.names=F)
wide <- read.csv(file="C:/R_Studio/Rscript/chapter/chapter06/data_wide.csv", header=T)
# 컬럼명 확인
colnames(wide)
# 컬럼명 변경
colnames(wide) <- c("Customer_ID", "day1", "day2", "day3", "day4", "day5", "day6", "day7")
str(wide) # 8개 변수, 5개 관측치
mode(wide); class(wide) # list, data.frame

# 넓은 형식을 긴 형식으로 변경
long <- melt(wide, id="Customer_ID")
name <- c("Customer_ID", "Date", "Buy")
colnames(long) <- name
long

# smiths 데이터 셋 구조 변경
smiths
str(smiths) # 5개 변수, 2개의 관측치

# 넓은 형식을 긴 형식으로
long <- melt(smiths, id=1:2)
str(long) # 4개 변수, 6개의 관측치
# 긴 형식 넓은 형식으로
wide1 <- cast(long, subject+time~...)
wide2 <- cast(long, ...~variable)
wide3 <- cast(long, subject+time~variable)
wide4 <- dcast(long, ...~variable)
# 동일한 결과
wide1; wide2; wide3; wide4

# 3차원 배열 형식으로 변경
# dcast() : data.frame 형식으로 구조 변경
# acast() : 3차원 구조를 갖는 배열(array)로 구조 변경
# acast(data, 행컬럼~열컬럼~측정컬럼)

# airquality 데이터 셋 구조변경
# 단계 1 : 데이터 셋 가져오기
data("airquality")
tbl_df(airquality)
str(airquality) # 6개 변수, 153개 관측치
mode(airquality); class(airquality) # list, data.frame
# 단계 2 : 컬럼명 대문자로 변경
library(stringr)
names(airquality) <- str_to_upper(names(airquality))
tbl_df(airquality)
head(airquality)
# 단계 3 : 넓은 형식을 긴 형식으로
air_melt <- melt(airquality, id=c(5,6), na.rm=T)
head(air_melt)
nrow(airquality)  # 153
nrow(air_melt) # 568 긴 형식으로 변경
# 단계 4 : acast() 이용 3차원으로 구조 변경
names(air_melt) <- tolower(names(air_melt)) # 컬럼명 소문자 변경
air_acast <- acast(air_melt, day~month~variable) # 행~열~면
str(air_acast) # 31행, 5열, 4면
mode(air_acast); class(air_acast) # numeric, array

# 단계 5 : 집합함수 적용
acast(air_melt, month~variable, sum, margins=T)
# month 컬럼을 기준으로 측정변수들의 합계를 계산
# margins=T : 각 행, 열의 합계컬럼을 추가

# 단게 6 : data.frame으로 구조 변경(거꾸로)
back1 <- melt(air_acast)
back2 <- dcast(back1, ...~X3)
names(back2)[1:2] <- c("DAY", "MONTH")
head(back2); head(airquality)
back2 <- select(back2, OZONE, SOLAR.R, TEMP, WIND, DAY, MONTH)
