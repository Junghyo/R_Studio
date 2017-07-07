# vector index는 1부터 시작
# 생성함수 : c(), rep(), seq()
# 처리함수 : union(), setdiff(), intersect()
x <- c(1,3,5,7,9)
y <- c(3,5)
x
y
xy <- c(x,y)
xy # 겹치는 부분도 중복되어 표시

# 합집합
union(x,y) # 겹치는 부분은 하나만 표시

# 차집합
setdiff(x,y) # x-y => 1,7,9
setdiff(y,x) # y-x => 0

# 교집합
intersect(x,y) # 3,5

v1 <- c(33, -5, 20:23, 12, -2:3)
v1
v2 <- c("Ronaldo", "Messi", "Neymar")
v2
v3 <- c(T, TRUE, F, FALSE, T, F, TRUE)
v3
v23 <- c(v2,v3)
v23
mode(v23)
class(v23) # logical과 character가 결합되면 character가 됨
v13 <- c(v1,v3)
v13
mode(v13)
class(v13) # logical과 숫자가 결합되면 numeric이 됨. T=1, F=0
v12 <- c(v1, v2)
v12
mode(v12)
class(v12) # character와 numeric이 결합되면 character가 됨
v4 <- c(1:5, "4")
v4 
mode(v4) # 숫자형에 문자형4가 있으면 전부 character로 변함
v4_n <- as.numeric(v4) # 숫자형으로 변환
mode(v4_n) # numeric
v13
as.logical(v13) # 숫자를 logical 변환시 0만 FALSE 나머지 수는 TRUE
# vector에 칼럼명 지정
age <- c(20, 30, 31)
age
names(age) <- c("Ronaldo", "Messi", "Rooney")
age

# vector 자료 참조하기 1
v5 <- seq(1,100,3) # 1~100  3간격 vector 생성
v5
v5[3:7] # index 3~7의 값 확인
v5[10: (length(v5)-5)] # 10 ~ 전체 길이에서 5를 뺀 길이의 값들 확인

# vector 자료 참조하기 2
v6 <- seq(1, 150, 4)
v6
v6[2]  # 두번째 index 확인
v6[c(3,7)] # 3번째, 7번째 index값 확인
v6[c(1, 4:6, 12)] # 1번째, 4~6번째, 12번째 index값 확인
v6[c(3:length(v6))] # 3번째 index부터 끝까지

# 음수값으로 index 지정
v6[-1] # 1번째 index 값 제외 확인
v6[-c(1:10)] # 1~10번째 index값 제외 확인

# vector 객체 데이터 셋
install.packages("RSADBE")
search()
library(RSADBE)
search()
require(RSADBE)
data(Severity_Counts)
str(Severity_Counts) # 1~10 총 10개의 데이터로 구성. 별명(names)이 설정됨
Severity_Counts
mode(Severity_Counts)
class(Severity_Counts)
Severity_Counts

# matrix
# 생성 함수: rbind(), cbind(), matrix()
# 행렬 자료 처리 함수 : apply(

# vector 이용 matrix객체 생성
m1 <- matrix(1:5) # matrix(c(1:5))와 동일
m2 <- matrix(c(1:5))
m1; m2;

# 열 우선 matrix
m3 <- matrix(1:10)
m3
m3_1 <- matrix(1:10, nrow=2) # row : 행 세로 2행 5열
m3_1
m4 <- matrix(c(1:11), nrow=2)
m4
mode(m4)
class(m4)
m5 <- matrix(c(1:10), nrow=2, byrow=T) # byrow 행 우선
m5
m6 <- matrix(c(1:10), nrow=2, byrow=F) # 열 우선
m6 
# rbind() : 행 묶음
x1 <- c(1:3, 5, 6)
x2 <- c(7:9, 3, 1)
r_x1x2 <- rbind(x1,x2)
r_x1x2

# cbind() : 열 묶음
c_x1x2 <- cbind(x1,x2)
c_x1x2

# n행 n열로 행렬 객체 생성
m3 <- matrix(10:19,5,2, byrow=F) # 5행 2열. 데이터 숫서 열 우선
m3
m4 <- matrix(1:10, 2, 5, byrow=T) # 2행 5열. 데이터 순서 행 우선
m4

# matrix 각 데이터 접근
m3
m3[,1] # 1열 데이터
m3[2,] # 2행 데이터
m3[3:5,] # 3~5행 데이터
m3[3:5,2] # 3~5행의 2열 데이터
m4
m4[1,c(2,4)] # 1행의 2열,4열 데이터

# 3행 3열 matrix
m5 <- matrix(1:9,3,3, byrow=T)
m5
length(m5) # m5 데이터 갯수 반환 
ncol(m5) # 열 갯수
nrow(m5) # 행 갯수

# apply() 함수
apply(m5, 1, max) # 1: 행. 행단위 최대값
apply(m5, 2, max) # 2: 열. 열단위 최대값
apply(m5, 2, mean) #  열단위 평균
apply(m5, 1, mean) # 행단위 평균

# 사용자 정의 함수
f <- function(x){
  x*c(1,2,3)
}
# 행단위를 적용하면 기본적으로 열단위로 결과가 출력(전치행렬)
result <- apply(m5, 1, f)
result

m5
result
m6 <- matrix(1:9, 3, 3)
m6
result2 <- apply(m6,1,f)
result2
# 열단위를 적용하면 기본적으로 열단위로 결과가 출력
result3 <- apply(m6,2,f)
result3
result4 <- apply(m5,2,f)
result4

c1 <- c(1,2,3)
c2 <- c(4,5,6)
c1*c2
m7 <- matrix(1:9,3,3)
m7
m8 <- matrix(1:4,2,2)
m8
m7*m8
m7*c1

# 행렬 객체의 컬럼명 지정하기
colnames(m6) <- c("one","two","three")
m6
rownames(m5) <- c("A","B","C")
m5
colnames(m5) <- c("first", "second", "third")
m5
str(m5)
# 열과 행 한꺼번에 별명 붙이기
dimnames(m7) <- list(c("a","b","c"),c("d","e","f"))
m7

# array 자료구조
v1 <- c(1:12)
v1
arr_v1 <- array(v1,c(2,2,3), 
  dimnames = list(c("row-a","row-b"),c("col-a","col-b"))) # 2행, 2열,3면
arr_v1
v2 <- c(1:20)
arr_v2 <- array(v2, c(2,2,5)) # 2행, 2열, 5면
arr_v2

# array 객체 데이터 읽기
arr_v1
arr_v1[,,3] # 3면의 데이터 읽기
arr_v1[,2,2] # 2면의 2열 데이터 읽기
arr_v1[2,1,1] # 1면의 2행 1열 데이터 읽기
mode(arr_v1)
class(arr_v1)
str(arr_v1)

# 등록된 library 확인
search()
data(Bug_Metrics_Software)
str(Bug_Metrics_Software) # 5행 5열 2면, 문자열
mode(Bug_Metrics_Software)
class(Bug_Metrics_Software) # xtabs, table
Bug_Metrics_Software

# List 자료 구조
# key와 value를 한쌍으로 갖는 자료구조
# 리스트 생성 함수 : list()
# 리스트 자료처리 함수 : unlist(), lapply(), sapply()

# list 객체 생성
list1 <- list("Ronaldo", "FW", 7)
list1
list1[1]
list1[[1]]
list1
mode(list1) # list
class(list1) # list
# vector 구조로 변경
unlist1 <- unlist(list1)
unlist1
class(unlist1)
mode(unlist1)
list2 <- list(c(1:5), c(1:6))
list2
list2[1]
list2[[1]]
class(list2)
mode(list2)

# key, value 형식으로 리스트 생성
list3 <- list(name="Ronaldo", position="FW", number=7)
list3
list3$name
str(list2)
str(list3)
str(list1)
list3$name <- "Marcelo"
list3
list3$name
# list team키 추가
list3$team <- "Real Madrid"
list3
list3$position <- NA
list3
# list 키 제거
list3$position <- NULL
list3
str(list3)

member <- list(name=c("Ronaldo", "Messi", "Rooney"), age=c(30,31,34), position=c("FW","FW","MF"))
member
# list 객체 자료 처리 함수
a <- list(c(1:5))
b <- list(c(6:10))
a
b
mode(a)
mode(b)
lapply(c(a,b), max)
c <- c(a,b)
d <- list(c(1:5),c(6:10))
d
c
str(c)
str(d)
# 두 개의 list 객체를 대상으로 max 함수 적용
# 가장 큰 값을 list 형태로 반환
lapply(d,max)
lapp <- lapply(c(a,b),max)
class(lapp); mode(lapp) # list, list

# vector 형태로 반환
sapp <- sapply(c(a,b),max)
sapp
class(sapp); mode(sapp) # integer, numeric

# data.frame 자료구조
# 1) list와 vector의 혼합형 : 컬럼은 list, 컬럼 내의 데이터는 vector
# data.frame 생성 함수 : data.frame(), read.table(), read.csv()
# 자료처리 함수 : str(), ncol(), nrow(), apply(), summary(), subset() 등

# list를 data.frame으로 변환
member_df <- data.frame(member)
member_df
mode(member_df); class(member_df) # list, data.frame
mode(member); class(member) # list, list

# vector이용 data.frame 생성
no <- c(7,9,10)
name <- c("Ronaldo", "Benzema", "Isco")
loc <- c("Portugal", "France", "Spain")
member2 <- data.frame(NO=no, NAME=name, LOC=loc)
member2
str(member2)
str(member_df)

# matrix 이용 data.frame 생성
member3 <- matrix(c(30,'Kaka','Milan',34,'Pirlo','Juventus',40,'Totti','Roma'), 3, 3, byrow=T)
member3
mode(member3); class(member3) # character, matrix
# matrix를 list로 변환
member3_list <- list(member3)
member3_list
mode(member3_list); class(member3_list) # list, list
member3_list[[1]][2,3]

member3_df <- data.frame(member3)
member3_df
names(member3_df) <- c("age", "name", "team")
member3_df
member3_df$age
str(member3_df)
mode(member3_df); class(member3_df) # list, data.frame

getwd()
emptxt <- read.table("emp.txt", header=T, sep="")
emptxt
emptxt$직책 <- c("짱", "사원", "부장", "에이스")
mean(emptxt$급여)
emptxt[1,] # 1행 값 가져옮
str(emptxt)
mode(emptxt); class(emptxt) # list, data.frame
empcsv <- read.csv("emp.csv", header=T, sep=",")
str(empcsv)
mode(empcsv); class(empcsv) # list, data.frame
help(read.csv)
empcsv

name <- c("no", "name", "sal")
emp2csv <- read.csv("emp2.csv", header = F, col.names=name)
emp2csv

# data.frame 만들기
df <- data.frame(x=c(1:5), y=seq(2,10,2), z=c("a","b","c","d","e"))
df
str(df)
mode(df); class(df); 

# data.frame 처리 함수
str(df) # 관측치(데이터) 5개, 변수 3개(x,y,z)
ncol(df) #3열
nrow(df) # 5행
names(df) # 변수(컬럼) 명
df[1:5,1:2]
df[2, c(2,3)] # 2행의 2열, 3열 데이터 확인

summary(df)
apply(df[,1:2], 1, sum) # 행 단위 연산
apply(df[,1:2],2,sum) # 열 단위 연산

# subset() : 조건에 맞는 부분회의
df
subset(df, x<=2|x>3) # 데이터 값이 2이하이거나 4이상인 경우만 나오게(3제외)
subset(df, !(x==3))
subset(df, x>3 & y<=8)
subset(df, x>=2 | y<=4 & y>2)

# student data.frame 만들기
grade <- c("A","B","C","D")
score <- c(100, 80,70,60)
subject <- c("math", "english", "history", "science")
student <- data.frame(성적=grade, 점수=score, 과목=subject)
student
str(student)
mode(student); class(student) # list, data.frame
str(grade)
str(student$성적)

# data.frame 두개 이상 결합하기
height <- data.frame(id=c(1,2), h=c(180,175))
weight <- data.frame(id=c(1,2), w=c(80,75))
str(height)
user <- merge(height,weight, by.x="id", by.y="id")
user

# data.frame 객체 데이터 셋
install.packages("psych")
require(psych)
data(galton)
galton
str(galton)
head(galton,15)
search(psych)
# 차원 보기
dim(galton) # 928개 데이터, 2개 변수
describe(galton)
# 데이터의 각 변수별 데이터 갯수, 평균, 표준편차, 중앙값, 10% 절사평균, 
# 중위수 절대편차, 최소값, 최대값, 범위, 왜도, 첨도, 표준오차

install.packages("stringr")
require(stringr)
# stringr 패키지 제공 함수
# 1) str_length() : 문자열 길이 반환
# 2) str_c() : 문자열 연결(결합), str_join()함수 개선
# 3) str_sub() : 범위에 해당하는 부분 문자열 생성
# 4) str_split() : 구분자를 기준으로 문자열을 분리하여 부분 문자열 생성
# 5) str_replace() : 기존 문자열을 특정 문자열로 교체
# 6) str_extract() : 문자열에서 특정 문자열 패턴의 첫번째 문자열 추출
# 7) str_extract_all() : 문자열에서 특정 문자열 패턴의 모든 문자열 추출
# 8) str_locate() : 문자열에서 특정 문자열 패턴의 첫번째 위치 찾기
# 9) str_locate_all() : 문자열에서 특정 문자열 패턴의 첫번째 위치 찾기