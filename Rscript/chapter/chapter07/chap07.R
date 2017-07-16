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
# 현재 resident변수 데이터값들이 1~5 숫자로 되어있어 거주지를 한번에 파악하기 불가능하다.
# 따라서 코딩변경 작업이 필요하다.
table(dataset$resident) # 1~5 외 값은 없는 것으로 보아 극단치는 존재하지 않는다.
summary(dataset$resident) # 결측치 15개 존재
dataset$resident2[dataset$resident==1] <- '서울'
dataset$resident2[dataset$resident==2] <- '인천'
dataset$resident2[dataset$resident==3] <- '대전'
dataset$resident2[dataset$resident==4] <- '대구'
dataset$resident2[dataset$resident==5] <- '기타'
dataset[c("resident", "resident2")]

# job 컬럼 코딩변경
summary(dataset$job) # 결측치 12개 존재
dataset$job2[dataset$job==1] <- "공무원"
dataset$job2[dataset$job==2] <- "회사원"
dataset$job2[dataset$job==3] <- "개인사업"
dataset[c("job","job2")]

# 척도변경을 위한 코딩
# 나이변수 : 21~69 분포
# <30 : 장년층, 31~55 : 중년층, 56< : 장년층으로 age2라는 범주형변수를 만들고 싶다.
summary(dataset$age) # 결측치 없음
dataset$age2[dataset$age<30] <- "청년층"
dataset$age2[dataset$age>=30 & dataset$age<56] <- "중년층"
dataset$age2[dataset$age>=56] <- "장년층"
dataset[c("age","age2")]
head(dataset)

# 역코딩을 위한 변경
# dataset$survay(만족도)의 설문지 문항을
# 1 매우 만족, 2 만족, 3 보통, 4 불만, 5 매우 불만
# 형태로 작성되었을 때 변경하지 않고 코딩하게 되면 점수화가 역순으로 되어버린다.
# 따라서 매우 만족~매우 불만의 순서를 역순으로 변경해야 하는데 이러한 작업을 
# 역코딩이라고 한다.
# 이러한 역코딩을 하기 위해서는 "(범주수+1)-데이터값"으로 처리하면 된다.

# 만족도(survey)를 긍정순서로 역코딩
summary(dataset$survey)  # 결측치, 극단치 없음
head(dataset$survey) #  기존  : [1] 1 2 4 2 1 2
dataset$survey <- 6-dataset$survey
head(dataset$survey) # 역코딩 : [1] 5 4 2 4 5 4

# 탐색적 분석을 위한 시각화

# 범주형 vs 연속형
# 범주형 : 명목척도, 서열척도
# 연속형 : 등간척도, 비율척도

# 데이터 셋 가져오기. Part-II,  new_data.csv
new_data <- read.csv(file.choose(), header=T)
new_data
str(new_data) # 11개 변수, 217개 관측치
mode(new_data); class(new_data)  # list, data.frame
levels(new_data$resident2) <- c("1.서울특별시", "2.인천광역시", "3.대전광역시",
                                "4.대구광역시", "5.시군구")
new_data$resident2[new_data$resident==1] <- "1.서울특별시"
new_data$resident2[new_data$resident==2] <- "2.인천광역시"
new_data$resident2[new_data$resident==3] <- "3.대전광역시"
new_data$resident2[new_data$resident==4] <- "4.대구광역시"
new_data$resident2[new_data$resident==5] <- "5.시군구"
new_data$job2[new_data$job==1] <- "공무원"
new_data$job2[new_data$job==2] <- "회사원"
new_data$job2[new_data$job==3] <- "개인사업"
summary(new_data$position)
new_data$postion2[new_data$position==1] <- "1급"
new_data$postion2[new_data$position==2] <- "2급"
new_data$postion2[new_data$position==3] <- "3급"
new_data$postion2[new_data$position==4] <- "4급"
new_data$postion2[new_data$position==5] <- "5급"
new_data$postion2 <- as.factor(new_data$postion2)
write.csv(new_data, "new_data.csv")

# 범주형 vs 범주형 데이터 분포 시각화
# 단계 1 : 거주지역과 성별 컬럼을 대상으로 빈도수 구하기
resident_gender <- table(new_data$resident2, new_data$gender2)
resident_gender
gender_resident <- table(new_data$gender2, new_data$resident2)
gender_resident

# 단계 2 : 성별에 따른 거주지역 분포 현황 시각화
pdf.options(family="Korea1")
pdf("C:/R_Studio/Rscript/chapter/chapter07/gender_resident_barplot.pdf")
barplot(resident_gender, beside=T, col=rainbow(5), legend=row.names(resident_gender),
        main="성별에 따른 거주지역 분포 현황")

# 단계 3 : 거주지역에 따른 성별 분포 현황
barplot(gender_resident, beside=T, col=c(1,2), legend=c("남자", "여자"),
        main="거주지역별 성별 분포 현황")
dev.off()

# 연속형vs범주형 
# 연속형변수(나이), 범주형변수(직업유형) 
# 단계 1 : lattice package 설치
install.packages("lattice")
library(lattice)
# lattice package : 고급시각화 분석에서 사용되는 package

# 단계 2 : 직업유형에 따른 나이 분포 현황
pdf("C:/R_Studio/Rscript/chapter/chapter07/age_job2_plot.pdf")
str(new_data)
densityplot(~age, data=new_data, groups=job2, plot.points=T, auto.key=T,
            main="직업 유형에 따른 나이의 분포 현황[densityplot]")
boxplot(new_data$age~new_data$job2, main="직업별 나이 분포 형황[boxplot]")
library(dplyr)
dev.off()
