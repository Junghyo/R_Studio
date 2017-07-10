# 키보드 입력
num <- scan()
1
2
3
4
5
num
mode(num); class(num) # numeric, numeric
sum(num)
# 키보드 입력(문자)
name <- scan(what="")
Ronaldo
Rooney
Messi
Neymar
name
mode(name); class(name) # character, character

# edit() 입력
df <- data.frame()
df <- edit(df)
df
mode(df); class(df) # list, data.frame
str(df)

# read.table() 함수
getwd()
setwd("C:/Users/acorn/Documents/R_Studio/Part-I")
student <- read.table(file="student.txt", header=F)
student
names(student) <- c("code", "name", "height", "weight")
student
str(student)
plot(student$weight~student$height)

# 컬럼명 있는 파일 불러오기
student1 <- read.table(file="student1.txt", header=T)
student1
str(student1)
mode(student1); class(student1) # list, data.frame
summary(student1)

# 탐색기를 통해서 파일선택하기
student1_1 <- read.table(file.choose(), header=T)
student1_1

# 구분자가 있는 경우 sep 사용
student2 <- read.table(file="student2.txt", sep=";", header=T)
student2
# 결측치 처리하여 파일 불러오기 (student3.txt 에 결측치는 -표시되어 있음)
stu3 <- read.table(file="student3.txt", header=T, sep="", na.strings="-")
stu3
View(stu3)

# read.csv()함수 이용
stu4 <- read.csv(file="student4.txt", sep=",", header=T, na.strings="-")
stu4 # csv는 구분자(sep)가 ,가 default이기 때문에 생략 가능

# read.xlsx()함수 이용
# 엑셀 파일(*.xlsx)을 직접 불러옴
# 1단계 : xlsx package 설치
# 2단계 : rJava package 설치
# 3단계 : Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_121") 설정
# 4단계 : rJava 라이브러리 로드
# 5단계 : xlsx 라이브러리 로드
install.packages("xlsx")
install.packages("rJava")
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_121")
require(rJava)
require(xlsx)
stu_excel <- read.xlsx(file="studentexcel.xlsx", sheetIndex = 1, encoding="UTF-8")
# sheetIndex : 해당 엑셀 파일에서 사용할 시트탭 지정
stu_excel
mode(stu_excel); class(stu_excel) # list, data.frame
str(stu_excel)
pdf("C:/Users/acorn/Documents/R_Studio/Rscript/chapter/chapter03/student.pdf")
plot(stu_excel$성적~stu_excel$이름, main="학생별 성적분포")
dev.off()

# 인터넷에서 파일 가져오기
# 세계 GDP 순위 데이터 가져오기
# http://databank.worldbank.org
# http://databank.worldbank.org/data/download/GDP.csv
gdp_rank <- read.csv("http://databank.worldbank.org/data/download/GDP.csv")
gdp_rank
View(gdp_rank)
gdp_rank <- gdp_rank[-c(1:5), c(1,2,4,5)] # 1~5행 삭제, 1,2,4,5열 선택
names(gdp_rank) <- c("n_code", "rank", "nation", "gdp")
str(gdp_rank) # 4개 변수, 325 관측치(데이터)
summary(gdp_rank)
describe(gdp_rank)
head(gdp_rank)
# 테이블 pdf 저장 package
install.packages("gridExtra")
require(gridExtra)
pdf("C:/Users/acorn/Documents/R_Studio/Rscript/chapter/chapter03/gdp_rank15.pdf")
# 테이블 저장 
grid.table(head(gdp_rank, 15))
dev.off()

# 상위 15개 사용
gdp_rank15 <- head(gdp_rank, 15)
gdp_rank15

# 막대차트 시각화
# 1단계 : gdp와 나라 컬럼 추출
# gdp 컬럼 추출
gdp <- gdp_rank15$gdp
# nation 컬럼 추출
nation <- gdp_rank15$nation
gdp
nation

# 2단계 : 문자열 처리
install.packages("stringr")
require(stringr)
mode(gdp); class(gdp) # numeric, factor
# gdp의 , 공백으로 변환
num_gdp <- as.numeric(str_replace_all(gdp, ",", ""))
num_gdp
mode(num_gdp); class(num_gdp) # numeric, numeric
gdp_rank15$gdp <- num_gdp
# 1) 막대차트 그리기
barplot(gdp_rank15$gdp/1000, col=rainbow(15), xlab="국가(nation)", ylab="단위(달러)", names.arg=nation)
# 2) y축 범위와 이름 지정 
barplot(gdp_rank15$gdp/1000, ylim=c(0,20000), main="2015년도 GDP 세계 10위 국가", 
        col=rainbow(10), ylab="단위:1,000달러", xlab="country")
# 3) y축 수정 후 막대차트 그리기
pdf.options(family = "Korea1deb") # pdf 한글변환
pdf("C:/Users/acorn/Documents/R_Studio/Rscript/chapter/chapter03/barplot_gdp15.pdf")
barplot(gdp_rank15$gdp/1000, ylim=c(0,20000), xlab="국가(nation)", ylab="단위(달러)",
        col=rainbow(15), main="2017년도 GDP 세계 15위 국가", names.arg=nation)
dev.off()

# 웹문서 가져오기(HTML 양식)
# 미국의 각 주별 1인당 소득 자료 : http://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015
# 1단계 package 설치
install.packages("XML")
install.packages("RCurl")
require(XML)
#URI를 가져 오는 등, 도착 및 게시물 양식 및 웹 서버에 의해 반환 된 결과를 처리하는 편리한 기능을 제공
require(RCurl)
url <- "https://www.infoplease.com/business-finance/poverty-and-income/capita-personal-income-state"
info.url <- getURL(url)
info.url
# header=T : 테이블에 컬럼명이 포함됨
# which=1 : 첫번째 줄에 제목 행이 있음
# stringsAsFactors=F : 문자열을 요인으로 처리하지 않고 순수한 문자열로 가져옴
info_df <- readHTMLTable(info.url, header=T, which=1, stringsAsFactors=F)
info_df
View(info_df)
str(info_df)
mode(info_df); class(info_df) # list, data.frame
require(stringr)
info_df$`1980` <- as.numeric(str_replace_all(info_df$`1980`, ",", ""))
info_df$`1990` <- as.numeric(str_replace_all(info_df$`1990`, ",", ""))
info_df$`1995` <- as.numeric(str_replace_all(info_df$`1995`, ",", ""))
info_df$`2000` <- as.numeric(str_replace_all(info_df$`2000`, ",", ""))
info_df$`2003` <- as.numeric(str_replace_all(info_df$`2003`, ",", ""))
info_df$`2006` <- as.numeric(str_replace_all(info_df$`2006`, ",", ""))
info_df$`2009` <- as.numeric(str_replace_all(info_df$`2009`, ",", ""))
info_df$`2012` <- as.numeric(str_replace_all(info_df$`2012`, ",", ""))
info_df$`2015` <- as.numeric(str_replace_all(info_df$`2015`, ",", ""))
info_df <- info_df[-c(1,27),]
# state 인자 설정
info_df$State <- factor(info_df$State)
pdf("C:/Users/acorn/Documents/R_Studio/Rscript/chapter/chapter03/info_df15.pdf")
grid.table(head(info_df, 15))
dev.off()
plot(head(info_df,15))
pdf("C:/Users/acorn/Documents/R_Studio/Rscript/chapter/chapter03/info_df15_plot.pdf")
par(mfrow=c(2,2))
plot(head(info_df,15))
plot(info_df$`1980`~info_df$State)
dev.off()

# 데이터 저장하기
# 화면에 출력하는 함수 : cat(), print()
x <- 10
y <- 20
z <- x*y
# cat은 문자열과 같이 사용 가능
cat("x*y의 결과는 ",z,"입니다.\n")
cat("x*y=",z)
# print는 값만 반환
print(z)
z

# 파일 저장하기
# 1. sink()
getwd()
setwd("C:/Users/acorn/Documents/R_Studio/output")
library(RSADBE)
data(Severity_Counts)
sink("severity.txt")
severity <- Severity_Counts
severity
sink()

# 2. write.table()
stu_excel <- read.xlsx(file.choose(), sheetIndex = 1, encoding="UTF-8")
# 단계 1 : 기본 속성으로 저장. 행 번호와 따옴표가 붙는다. 
write.table(stu_excel, "stdt.txt")
# 단계 2 : row.names=FALSE 속성을 이용하여 행 번호 제거 후 저장
write.table(stu_excel, "stdt2.txt", row.names=F)
# 단계 3 : qoute=F를 이용하여 따옴표도 제거 후 저장
write.table(stu_excel, "stdt3.txt", row.names=F, quote=F)
stu1 <- read.table(file.choose(), header=T)
stu1
setwd("C:/Users/acorn/Documents/R_Studio/output")
gdp_rank15
write.table(gdp_rank15, "gdp_rank15.txt", row.names=F)
gdp_r15 <- read.table(file.choose(), header=T)
gdp_r15
View(gdp_r15)

# 3. write.xlsx()
library(xlsx)
st.df <- read.xlsx(file.choose(), sheetIndex = 1, encoding="UTF-8")
str(st.df)
write.xlsx(st.df, "students.xlsx")
write.csv(st.df, "stdf.csv", row.names=F, quote=F)

# 주식데이터 처리
# https://www.google.com/finance
getwd()
setwd("C:/Users/acorn/Documents/R_Studio/Part-I")
sam_kospi <- read.csv(file="sam_kospi.csv", header=T)
sam_kospi
View(sam_kospi)
names(sam_kospi$癤풡ate) <- "Date"
names(sam_kospi) <- c("Date", "Open", "High", "Low", "Close", "Volume")
# xyplot()을 위한 package
install.packages("lattice")
require(lattice)
sam_kospi15 <- head(sam_kospi, 15)
str(sam_kospi)
mode(sam_kospi15); class(sam_kospi15) # list, data.frame

# 날짜 칼럼 추출 및 자료구조 확인
mode(sam_kospi15$Date); class(sam_kospi15$Date) # numeric, factor
# 로케일 변경(자료가 미국 자료이기 때문)
Sys.setlocale(category="LC_ALL", locale="English_US")
Sys.getlocale()
# 요인형을 날짜형으로 변환
Rdate <- strptime(as.character(sam_kospi15$Date), "%d-%b-%y")
Rdate
mode(Rdate); class(Rdate) # list, POSIXt
# 수정된 날짜로 갱신
sam_kospi15$Date <- Rdate
# POSIXt : R에서 날짜와 시간을 표현할 수 있는 자료형
# 상한가, 하한가를 y축, 날짜를 x축으로 xyplot 그리기
par(mfrow=c(1,1))
pdf("C:/Users/acorn/Documents/R_Studio/Rscript/chapter/chapter03/sam_kospi15.pdf")
require(gridExtra)
grid.table(sam_kospi15)
xyplot(High+Low~Date, type="l", data=sam_kospi15)
dev.off()
info_df15 <- head(info_df, 15)
pdf("C:/Users/acorn/Documents/R_Studio/Rscript/chapter/chapter03/info_df15_xyplot.pdf")
xyplot(info_df15$`1980`+info_df15$`1990`~info_df15$State, type="l")
xyplot(info_df15$`1980`+info_df15$`1990`+info_df15$`2012`+info_df15$`2015`~info_df15$State, type="l")
dev.off()
