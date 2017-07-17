# 7장 연습문제

# 1. 본문에서 생성된 dataset2의 직급(position) 컬럼을 대상으로 1급-> 5급, 5급->1급으로
# 역코딩하여 position2 컬럼에 추가하시오.
dataset2 <- read.csv(file.choose(), header=T) # Part-II, dataset.csv
str(dataset2) # 7개 변수, 300개 관측치
summary((dataset2$position))
dataset2$position2 <- 6-dataset2$position
dataset2[c("position", "position2")]

# 2. dataset2의 resident 컬럼을 대상으로 NA값을 제거한 후 dataset2 변수에 저장하시오.
summary(dataset2$resident) # 결측치 21개
dataset2 <- subset(dataset2, !is.na(dataset2$resident))
summary(dataset2$resident) # 결측치 0개

# 3. dataset2의 gender 컬럼을 대상으로 1->"남자", 2->"여자" 형태로 코딩 변경하여 gender2
# 컬럼에 추가하고 파이차트로 결과를 확인하시오.
summary(dataset2$gender) #이상값 존재 : 0, 5
dataset2 <- subset(dataset2, dataset2$gender==1 | dataset2$gender==2)
summary(dataset2$gender)
dataset2$gender2 <- ifelse(dataset2$gender==1,"남자", "여자")
pie(table(dataset2$gender2))
str(dataset2)

# 4. 나이를 30세 이하-->1, 31~54 -->2, 55이상-- 3으로 리코딩하여 age3 컬럼에 추가한 후
# age, age2, age3 컬럼만 확인하시오.
summary(dataset2$age) # 결측값 27개 존재
# age 결측치 제거
dataset2 <- subset(dataset2, dataset2$age>=20 & dataset2$age<=69)
# age2 생성[청년층, 중년층, 장년층]
dataset2$age2[dataset2$age<=30] <- "청년층"
dataset2$age2[dataset2$age>=31 & dataset2$age<=54] <- "중년층"
dataset2$age2[dataset2$age>=55] <- "장년층"
# age3 생성
dataset2$age3[dataset2$age2=='청년층'] <- 1
dataset2$age3[dataset2$age2=='중년층'] <- 2
dataset2$age3[dataset2$age2=='장년층'] <- 3
dataset2[c("age","age2","age3")]

# 5.정제된 데이터를 해당 폴더(chapter07_ex)에 cleanData.csv 파일명으로 따옴표와 행 이름을 
# 제거하여 저장하고 new_data변수로 읽어오시오.
getwd()
setwd("C:/R_Studio/Rscript/chapter_ex/chapter07")
write.csv(dataset2, "cleanData.csv", quote=F, row.names=F)
new_data <- read.csv(file="cleanData.csv", header=T)
str(new_data)
library(lattice)
densityplot(~survey | factor(age2), data=new_data, groups=gender2, auto.key=T,
            plot.points=T)

# 6. user_data.csv와 return_data.csv 파일을 이용하여 각 고객별 반품사유코드(return_code)를
# 대상으로 다음과 같이 파생변수를 추가하시오.
# 6-1. 반품사유코드에 대한 파생변수 컬럼명 설명
# 제품이상(1) -> return_code1, 변심(2) -> return_code2, 
# 윈인불명(3) -> return_code3, 기타(4) -> return_code4
user_data <- read.csv(file.choose(), header=T)
return_data <- read.csv(file.choose(), header=T)
str(user_data)
str(return_data)
library(reshape2)
user_return <- dcast(return_data, user_id~return_code, sum, na.rm=T )
# Using return_code as value column: use value.var to override.
head(user_return)
names(user_return)[2:5] <- c("return_code1", "return_code2", "return_code3", "return_code4")
library(plyr)
user_return_data <- join(user_data, user_return, by="user_id")
head(user_return_data, 10)
write.csv(user_return_data, "user_return_data.csv", quote=F, row.names=F)
