# 6장 연습문제

# (plyr package)
# 1. mtcar 데이터 셋을 대상으로 차종별 실린더 수와 기어 단수별로 각 단계에 맞게 연비의 평균과
# 표준편차의 통계치를 계산하시오.
library(plyr)
data("mtcars")
head(mtcars)
# 1-1. 데이터 구조 확인
str(mtcars) # 11개 변수, 32관측치
mode(mtcars); class(mtcars) # list, data.frame
names(mtcars) # 컬럼(변수)명
# 1-2. 통계치 계산
help(mtcars)
mtcars_cyl <- ddply(mtcars, .(cyl), summarise, avg=mean(mpg), sd=sd(mpg))
mtcars_cyl
mtcars_gear <- ddply(mtcars, 10, summarise, avg=mean(mpg), sd=sd(mpg))
mtcars_gear
mtcars_cyl_gear <- ddply(mtcars, c(2,10), summarise, avg=mean(mpg), sd=sd(mpg))
mtcars_cyl_gear

# (dplyr package) 
# data(hflights) 사용
# 2. 평균 비행시간을 구하시오.
library(dplyr)
library(hflights)
tbl_df(hflights)
mean(hflights$AirTime, na.rm=T)

# 3. n(), sum()을 이용하여 평균 비행시간을 구하시오.
str(hflights)
mode(hflights); class(hflights)
names(hflights)
summarise(hflights, cnt=n(), mean=(sum(hflights$AirTime, na.rm=T)/cnt))

# 4. NA값으로 인하여 평균에 차이가 발생하였다. 이를 보정하시오.
length(hflights$AirTime[!is.na(hflights$AirTime)]) # AirTime에서 NA값을 뺀 데이터의 길
summarise(hflights, cnt=length(AirTime[!is.na(AirTime)]), mean=(sum(AirTime, na.rm=T)/cnt))
mean(hflights$AirTime, na.rm=T)

# 5. 도착시간(ArrTime)의 표준편차와 분산을 구하시오.
summarise(hflights, sd=sd(ArrTime, na.rm=T), var=var(ArrTime, na.rm=T))

# (reshape2 package)
# 6. reshape2 package를 적용하여 각 다음 조건에 맞게 iris 데이터 셋을 적용하시오.
library(reshape2)
tbl_df(iris)
str(iris) # 5개변수, 150개관측치
names(iris) # 컬럼(변수)명
# 6-1. 꽃의 종류를 기준으로 넓은 형식을 긴 형식으로 변경하기
nrow(iris)  # 150
iris_wide <- melt(iris, id="Species")
nrow(iris_wide) # 600
# 6-2. 꽃의 종별로 나머지 4가지 변수의 합계 구하기
dcast(iris_wide, Species~variable, sum)
setosa <- filter(iris, iris$Species=='setosa')
versicolor <- filter(iris, iris$Species=='versicolor')
virginica <- filter(iris, iris$Species=='virginica')

# 기술통계량 package
install.packages("pastecs")
library(pastecs)
stat.desc(setosa)
stat.desc(versicolor)
stat.desc(virginica)
# 동일하다. 

# 6-3. 꽃의 종별로 4가지 변수 평균과 각 행/열 대상 평균 계산 칼럼 추가.
head(iris)
head(iris_wide)
stat.desc(iris)
iris_acast <- acast(iris_wide, Species~variable, mean, margins=T)
iris_acast
