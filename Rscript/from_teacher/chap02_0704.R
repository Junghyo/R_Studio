# data.frame 객체 생성
# data.frame(컬럼1=백터형데이터, 컬럼2=백터형데이터, ...)
no <- c(1,2,3)
pay <- c(150, 250, 300)
name <- c("Ronaldo", "Messi", "Rooney")
vemp <- data.frame(NO=no, PAY=pay, NAME=name)
vemp
mode(vemp)
class(vemp)
m <- matrix(c(1,"호날두", 150, 2, "메시", 250, 3, "루니", 300), 3, by=T)
m
memp <- data.frame(m)
memp
vemp
# 파일에 있는 데이터 로딩을 통해 dataframe 생성
# read.table("data파일명", header=T(헤더처리유무), sep=""(구분자 처리))
getwd()
setwd("C:/Users/acorn/Documents/Rwork/Part-I")
getwd()
txtemp <- read.table("emp.txt", header=T, sep="")
txtemp
csvemp <- read.csv("emp.csv", header=T)
csvemp
help(read.csv)
# 데이터 프레임 컬럼명 = 백터데이터
df <- data.frame(x=c(1:5), y=seq(2,10,2), z=c('a','b','c','d','e'))
df
mode(df)
class(df)
# 데이터 프레임의 컬럼을 통한 접근 방법
# 데이터 프레임에 할당된 변수명$특정한 컬럼명
df$x
df$z
example(hist)
# 데이터 형식 통한 지원하는 함수
# str(데이터 변수명) : 치료구, 열수, 행수, 컬럼명 보기
str(df)
summary(df)
# ncol, nrow, names, 데이터형식[c(시작:마지막)] : 범위 데이터 가져옮
# 서브셋(subset)
# 형식 : subset(데이터, 조건식) : 해당데이터에 조건식에 맞는 데이터를 추출
x <- 1:5
x
class(x)
mode(x)
y <- 6:10
df <- data.frame(x, y)
df
# x가 3이상인 레코드 가져오기
subset(df, x>=3)
subset(df, y<=8)
subset(df, x>3&y>1)
# 데이터 프레임 머지
# 데이터 프레임1과 데이터 프레임2를 통합(merge)할 때, 조건이 되는 key를 지정
# by="공통컬럼명"
height <- data.frame(id=c(1,2), h=c(180, 175))
weight <- data.frame(id=c(1,2), w=c(80,75))
user <- merge(height, weight, by.x="id", by.y="id")
user
example(plot)
plot(user)
install.packages("psych")
library(psych)
data("galton")
str(galton)
# dim : 해당 데이터의 차원에 관한 정보
dim(galton)
head(galton, 2)
data(galton)
head(galton, 20)
plot(galton)
# strigr : 문자열 처리 함수 지원하는 패키지
install.packages("stringr")
library(stringr) # 메모리에 해당 패키지 로딩
# str_extract("문자열", "정규표현식")
#[0-9] : 숫자를 검색, {2} : 연속된 데이터 => 연속된 2개의 숫자를 한번만 추출
# str_extract("문자열", "[0-9]{2}") => 해당 문자열에 연속된 2개의 숫자를 한번 추출
data01 <- str_extract("abcdef77d11ds33aa1257", "[0-9]{2}") # 한번만 추출
data02 <- str_extract_all("abcdef77d11ds33aa1257", "[0-9]{2}") # 해당 문자열 모두 추출
data01
data02
mode(data01)
class(data01)
mode(data02)
class(data02)
# 1. 반복되는 데이터를 추출하기 위한 정규식표현
str <- "ronaldo35messi45,네이마르55마나니,1나2"
# 연속된 영문자 3개 추출
data03 <- str_extract(str, "[a-z]{3}")
data03
data04 <- str_extract_all(str, "[a-z]{3}")
data04
# 연속된 숫자 추출(2개, 3개)
data05 <- str_extract_all(str, "[0-9]{2}")
data05
data06 <- str_extract_all(str, "[0-9]{3}")
data06
# 한글 추출하기
# 가~희
data07 <- str_extract_all(str, "[가-희]{4}")
data07
# 특정 문자열 추출
data08 <- str_extract(str, "네이")
data08
# 많이 활용되는 정규식 표현처리
# 단어: \\w
# 숫자: \\d
# 숫자: \\d
# 주민등록번호 양식 검사
# 6자리~7자리(첫자리(1,2,3,4)+6자리) [1,2,3,4][0-9]{6}
code <- '홍길동서울890415-1234567학생'
code
str_extract_all(code, '[0-9]{6}-[1,2,3,4][0-9]{6}')
# email 양식 검색
# 이메일은 문자로 4이상 시작하고 @반드시 입력하고 뒤에 3자리 이상
# 반드시 입력, 도메인이름은 문자로 2자리 이상
# tjwjdgy123@naver.com
# [a-z]{4,}@[a-z]{3,}.[a-z]{2,}
email <- '호날두tjwjdgy123@naver.com요다yoda@gmail.com서울'
data10 <- str_extract_all(email, '[a-z,0-9]{4,}@[a-z]{4,}.[a-z]{2,}')
data10
# 문자열 길이 구하기
length(data10)
str_length(email)
# length() : 문자열 길이
# str_length() : 문자열의 크기
# 부분 문자열 처리 str_sub(문자열, 시작, 마지막)
str_s <- str_sub(str, 5, 15)
str_s
# 문자열 교체
str2 <- "호날두, 메시, 네이마르"
str2
str_replace(str2, '호날두', '수아레즈')
# 문자열 분리
str_sp <- str_split(str2, ',')
str_sp
class(str2)
class(str_sp)
# 문자열 결합 paste()
str3 <- c('홍길동', '이순신', '유관순')
str_p <- paste(str3, collapse = ",")
str_p
str3
class(str3)
class(str_p)
ex1 <- rep('R',5)
ex1
ex2 <- seq(1,10,3)
ex2
ex3 <-rep(ex2, 3)
ex3
ex3_1 <- rep(ex2, each=3)
ex3_1
ex4 <- c(ex2,ex3_1)
ex4
ex5 <- seq(25, -15, -5)
ex5
idx <- c(1,3,5,7,9,11,13,15)
ex6 <- seq(ex4,2)
ex6
example(c)
name <- c("최민수", "유관순", "이순신", "김유신", "홍길동")
age <- c(55,45,45,53,15)
gender <- c(1,2,1,1,1)
example(factor)
people <- data.frame('이름'=name, '연령'=age, '성별'=gender)
people
str(people)
# 1. R문자 5번 반복
vec1 <- rep('R',5)
vec1
# 2. 1~10까지 3간격 연속
vec2 <- seq(1, 10,3)
vec2
# 3. 1~10까지 3간격 연속 3회 반복
vec3 <- rep(vec2, 3)
vec3
# 4. vec2, vec3 포함된 벡터
vec4 <- c(vec2, vec3)
vec4
# 5. 25~ -15까지 5 간격
vec5 <- seq(25, -15, -5)
vec5
# 6. 홀수번째 값만 처리하기
vec6 <- vec4[seq(1, length(vec4),2)]
vec6
# 7. data.frame
name <- c("최민수", "유관순", "이순신", "김유신", "홍길동")
age <- c(55,45,45,53,15)
gender <- c(1,2,1,1,1)
gender_f <- factor(gender, levels = c(1,2), labels = c("남자","여자"))
gender_f
person <- data.frame('이름'=name, '나이'=age, '성별'=gender_f)
person
str(person)
person[1]
person[2]
person[2,]
person[seq(2,5,2),]
gender_num <- as.numeric(person$성별)
hist(gender_num, breaks = c(0,1,2), main="남성 여성 히스토그램")
str(person)
# 분산 apply(데이터, 1, var)
# 표준편차 apply(데이터, 1, sd)
# 소숫점 2자리 표시 : round(데이터, 2)
# ^[a-z] : 첫자가 문자로 시작
# [a-z0-9] : 문자와 숫자를 쓰되, 4자이상
# {숫자} : 해당 자리수, {최소자리, 최대자리} : 자리수의 범위를 지정
# {4,} : 4자리 이상

# 키보드 입력
# scan 기본 입력 데이터 형식 : 숫자
# 문자 입력 : scan(what="")
x <- scan()
x
sum(x)
y <- scan(what="")
y
mode(y)
class(y)
# edit(데이터프레임)
# 컬럼과 데이터를 2차원 입력처리가능
# 1) 데이터프레임 선언
# 2) edit(프레임변수명)
# 3) 새로운 변수에 할당 처리
df = data.frame()
df
df = edit(df)
df
class(df)
plot(df$이름~df$학번)
hist(df$학번)
# 파일을 통한 데이터 로딩
# read.table(file="경로/파일", sep="컬럼구분자", header="타이틀처리여부-T/F")
getwd()
stu <- read.table(file="student.txt", header = F)
stu
# 컬럼명 변경 : names(데이터) <- 백터형으로 컬럼명 선언
names(stu) <- c("학번", "이름", "키", "몸무게")
stu
stu1 <- read.table(file="student1.txt", header=TRUE)
stu1
# 탐색기를 통해서 데이터 로딩
# 특정한 파일이 지정되지 않고 탐색기를 통해서 선택해서 데이터를 로딩할 때
# read.table(file.choose(), header=T)
student1 <- read.table(file.choose(), header = T)
student1
student2 <- read.table(file="student2.txt", sep=";", header=T)
View(student2)
student2
# 데이터 없는 부분에 대한 처리
# na.strings : na값으로 지정된 문자열을 할당하면 그 데이터는 na로 처리됨
student3 <- read.table(file="student3.txt", sep="", header=T, na.strings="-")
student3
# read.csv() : 함수를 통한 csv 데이터 로딩
# read.csv(file="파일/경로명")
stu4 <- read.csv(file="student4.txt", sep=",", na.strings="-")
stu4
View(stu4)
# read.xlsx() 함수 이용
# 1. jre를 JAVA_HOME으로 환경 setting
setwd("C:/Users/acorn/Documents/Rwork/Part-I")
getwd()
install.packages("rJava")
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_121")
library(rJava)
install.packages("xlsx")
library(xlsx)

# 웹 문서 가져오기
install.packages("XML")
library(XML)
info.url <- "http://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"
# 미국의 각 주별 1인당 소득 자료
# html 문서 내용 로딩 : readHTMLTable(url주소,)
# header=T : 컬렴명이 있다면
# which=1 첫번째 테이블
# stringsAsFactors : 문자는 범주(값의 목록)처리 안함
info.df <- readHTMLTable(info.url, header=T, which=1, stringsAsFactors=F)
str(info.df)
head(info.df)
tail(info.df)
# 인터넷상 파일데이터를 가져와서 필요한 데이터로 가공
# 히스토그램으로 화면 처리
# http://databank.worldbank.org/data/download/GDP.csv
# 1.데이터 가져오기
# 변수명 <- read.csv("url")
GDP_ranking <-read.csv("http://databank.worldbank.org/data/download/GDP.csv")
View(GDP_ranking)
str(GDP_ranking)
# 데이터 가공 : 불필요한 데이터 행과 열 삭제
GDP_ranking2 <-GDP_ranking[-c(1:4),c(1,2,4,5)]
GDP_ranking2
View(GDP_ranking2)
# 컬럼명 지정 : names(데이터) <- 백터로 컬럼명 지정
names(GDP_ranking2) <- c("코드값", "순위", "나라", "GDP")
# 326개의 데이터 중에 상위1 5개 국가만 확인. head(데이터, 15)
gdp_rank15 <- head(GDP_ranking2, 15)
# GDP 데이터 추출 변수$컬럼명
gdp <- gdp_rank15$GDP
gdp
nation <-gdp_rank15$나라
nation
# 통계치를 처리하는 차트에 데이터를 입력
# 문자열 --> 숫자
# ,는 삭제 문자열--> 숫자
# , --> '' : str_replace_all
# 숫자변환 : as.numeric
library(stringr)
num_gdp <- as.numeric(str_replace_all(gdp,',',''))
num_gdp
gdp_rank15$GDP <-num_gdp
View(gdp_rank15)
# 막대차트 그리기
# par(mfrow=c(1,1)) 구역 처리
par(mfrow=c(1,1))
barplot(gdp_rank15$GDP, col=rainbow(15), 
        xlab = "국가(nation)", ylab="gdp(단위:1,000달러)", names.arg=nation)
barplot(num_gdp/1000, ylim=c(0,20000), main="2015년도 GDP 세계 10위 국가", col=rainbow(20),
        ylab="단위:1000달러", xlab="country")
