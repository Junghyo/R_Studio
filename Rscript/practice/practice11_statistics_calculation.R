#------------------------------
# R version 3.4.1 (2017-06-30)
#
# @ Author: yoda
# @ Mon Jul 24 22:51:39 2017
# @ Asia/Seoul
#------------------------------


head(mtcars)
str(mtcars)  # 11개 변수, 32개 관측치

# mpg, cyl 컬럼만 데리고 새로운 data만들기
newdata <- mtcars[1:2]
newdata

# cyl 갯수별로 데이터 나누기
mpg_4 <- newdata[newdata$cyl==4, ]
mpg_6 <- newdata[newdata$cyl==6, ]
mpg_8 <- newdata[newdata$cyl==8, ]

# cyl별 mpg 평균값 계산하여 cbind()로 묶기
mean_mpg <- cbind(mean(mpg_4$mpg), mean(mpg_6$mpg), mean(mpg_8$mpg))
class(mean_mpg) # matrix

?tapply # tapply 도움말

# tapply를 이용하면 cyl별 mpg 평균값을 쉽게 구할 수 있다.
# tapply 이용
tapply(newdata$mpg, newdata$cyl, mean)
tapply(mtcars$mpg, mtcars$cyl, mean)

# ddply이용
library(dplyr)
library(plyr)
ddply(mtcars, .(cyl), summarise, mean=mean(mpg))
ddply(newdata, .(cyl), summarise, mean=mean(mpg))

# dcast, acast 이용
library(reshape2)
mtcars_l <- melt(mtcars, id=c(-1))
head(mtcars_l)
dcast(mtcars_l, cyl~variable, mean)
acast(mtcars_l, cyl~variable, mean, margins=T)
