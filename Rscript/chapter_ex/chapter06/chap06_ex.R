# 6장 연습문제

# 1. mtcar 데이터 셋을 대상으로 차종별 실린더 수와 기어 단수별로 각 단계에 맞게 연비의 평균과
# 표준편차의 통계치를 계산하시오(plyr package)
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
summarise(hflights, cnt=length(hflights$AirTime[!is.na(hflights$AirTime)]), mean=(sum(hflights$AirTime, na.rm=T)/cnt))
