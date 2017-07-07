# 사용가능한 package 수 확인
dim(available.packages())
# 사용가능한 package 명 확인
available.packages()
# R 정보
sessionInfo()
# package 설치
install.packages("stringr")
# package 사용(libray 올리기) = require
library(stringr)
# 현재 library에 등록된 package
search()
library("bim")
libaray(blm)
require(blm)
# package 제거
remove.packages("stringr")
data()
# 랜덤 숫자 100개로 히스토그램 그리기
hist(rnorm(100))
hist(Nile)
# plot 칸 설정 1행 2열(한 화면에 2개씩)
par(mfrow=c(1,2))
hist(Nile)
hist(Nile, freq=F) # freq=F 상대도수(각 계급의 도수를 총 도수로 나눈 것)
hist(Nile, freq=T)
lines(density(Nile))
data(Nile)
Nile
getwd()
par(mfrow=c(1,1))
# PDF 저장 경로 및 이름 설정
pdf("C:/Users/acorn/Documents/Rwork/batch.pdf")
# 그래프 저장
hist(rnorm(20))
# PDF 종료
dev.off()
goods.code <- 'a001'
goods.name <- '냉장고'
goods.price <- 850000
goods.des <- 'A급'
age <- 25
age
age <- T
age
mode(age)
class(age)
age <- NULL
age
mode(age)
class(age)
num1 <- 10
num2 <- 20
num3 <- NA
sum(num1, num2)
# NA 때문에 계산 안됨
sum(num1, num2, num3 )
# NA 빼고 계산
sum(num1, num2, num3, na.rm=T)
ls()
result
is.nan(result)
is.nan(num1)
is.na(num3)
is.nan(num3)
is.nan(20)
is.numeric(10)
# 복소수
is.complex(5+3i)
is.factor(a)
name <- "홍길"
is.factor(name)
as.numeric(name)
x <- c(1,2,"3")
x*3
as.numeric(x)*3
as.double(x)*3
z <- 5.3 - 3i
z
is.complex(z)
# 실수
Re(z)
# 허수
Im(z)
as.complex(5.3)
class(x)
y <- c(1,2,T)
class(y)
y*2
class(c(T,F))
c(T,F)*3
gender <- c("man", "woman", "man", "man", "woman")
class(gender)
mode(gender)
plot(gender)
Ngender <- factor(gender)
Ngender
plot(Ngender)
table(Ngender)
gender
str(gender)
str(Ngender)
mode(Ngender)
class(Ngender)
args(factor)
example(factor)
Ogender <- factor(gender, levels=c("woman","man"), ordered=T)
Ogender
plot(Ogender)
par(mfrow=c(1,2))
pdf("C:/Users/acorn/Documents/Rwork/gender.pdf")
dev.off()
Sys.getlocale()
Sys.getlocale(category="LC_TIME")
Sys.time()
Sys.Date()
class(Sys.Date())
mode(Sys.Date())
class(Sys.time())
mode(Sys.time())
date <- "2017-06-24 15:37:24"
class(sdate)
mode(sdate)
sdate <- strptime(date, "%Y-%m-%d %H:%M:%S")
sdate
Sys.getlocale()
Sys.setlocale(category="LC_ALL", locale="Korean_Korea")
Sys.setlocale(category = "LC_ALL", locale="English_US")
strptime("01-jan-15", "%d-%b-%y")
day <- "saturday, 23 jan 2016"
day
sday <- strptime(day, "%A, %d %b %Y")
sday
weekdays(sday)
mode(sday)
class(sday)
days <- c("1may99", "30june69", "24april00")
sdays <- strptime(days, "%d%b%y")
sdays
help(mean)
?sum
args(max)
max(10,20)
?args
example(args)
example(seq)
mean(10:20)
mean(10:15)
x <- c(0:10, 50)
x
mean(x)
str(x)
summary(x)
x <- c(0:10, 50, 60, NA)
mean(x)
summary(x)
mean(x, na.rm=T)
getwd()
data <- read.csv(file.choose(), header=T)
data
barplot(data)
plot(data)
barplot(data$A)
barplot(data$B)
getwd()
setwd("C:/Users/acorn/Documents/Rwork/Part-I")
getwd()
name <- NA
name <- "홍길동"
age <- 25
address <- "서울"
is.character(address)
is.numeric(age)
women
mode(women)
class(women)
str(women)
plot(women, type="o",cex=2, col="red", lwd=1, pch="+")
plot(women$weight~women$height)
plot(women$height~women$weight)
