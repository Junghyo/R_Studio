par(mfrow=c(1,2))
plot(fgender)
plot(ogender)
# 날짜형 처리
Sys.Date()
Sys.time()
# 문자열 -> 날짜형 처리
today <- '2017-07-03 11:41:22'
today
mode(today)
class(today)
# format: 날짜/시간 관련 양식 문자로 처리
# strptime(날짜/시간, 'format 형식 %Y %m %d %H %M %S')
stoday <- strptime(today, '%Y-%m-%d %H:%M:%S')
stoday
class(stoday)
strptime("01-05-2015",format="%d-%m-%Y")
data2015 <- strptime("01-05-2015", format="%d-%m-%Y")
data2015
# 국가별 지역처리 설정(locale)
# 다국어 확인 Sys.getlocale()
# 다국어 변경 Sys.setlocale(local="English_USA")
# 영어식 -> 한국식
sdate <- "13-Jun-16" # 2016-06-13
sdate
Sys.getlocale()
Sys.setlocale(locale="English_USA")
kdate <- strptime(sdate, '%d-%b-%y')
kdate
Sys.setlocale(locale="Korean_Korea")
help(main)
# help(함수) 도움말에 대한 처리
mean(10,20,30)
x <- c(10,20,30)
mean(x)
sum(10,20,NA,30)
arg(sum)
args(sum)
x <- c(10, 20, NA, 30)
sum(x)
sum(x, na.rm=TRUE)
# args(함수) : 함수의 입력값을 확인 후, 해당 부분에 대한 처리
example(sum)
# exaple(함수명) : 해당함수의 활용방법
example(seq)
getwd()
getwd()
setwd('C:/Users/acorn/Documents/Rwork/Part-I')
data <-read.scsv("test.csv", header=T)
data <-read.csv("test.csv", header=T)
data
getwd()
name <- 0
name
name = '호날두'
name
age=32
age
address='포르투갈'
address
is.character(name)
is.numeric(age)
is.character(name)
is.character(age)
person <- c(name, age, address)
person
is.character(person)
is.numeric(person)
class(person)
women
class(women)
mode(women)
plot(weight~height, data=women)
fit = lm(weight~height, data=women)
abline(fit, col='red')
fit
example(list)
plot(women)
fit
abline(fit, col='blue')
num = c(1:100)
num
mean(num)
sum(num)
hist(Nile)
plot(women, main="여성 키와 몸무게의 상관관계")
fit = lm( height~weight, data=women)
abline(fit, col="red")
lm(weight~height, data=women)
women
Nile
plot(Nile)
class(Nile)
mode(Nile)
plot(women)

# R 프로그래밍 언어의 특징
# 1. 일반데이터, 함수, 차트 등 모든 데이터가 객체 형태로 관리
# 2. 모든 객체는 메모리로 로딩되어 고속으로 처리되고 재사용이 가능
# 3. 데이터 분석에 필요한 최신의 알고리즘 및 방법론을 제공
# 4. 데이터 분석과 표현을 위한 다양한 그래픽 도구를 제공


# vector 자료 구조
# ~ 동일한 자료형을 갖는 1차원 배열 구조
# ~ 생성함: c(), seq(), rep()
# 백터 데이터 생성 함수
# c(시작: 마지막) 콜론을 황요해서 범위 지정 처리
c(1:20)
vec1 = c(1:100)
vec1
# c(입력할 데이터1, 입력할 데이터2, ....., 입력할 데이터n)
vec2 = c(10, 20, 30, 40, 50)
vec2
# seq(시작데이터, 마지막데이터, 사이의 step단위(증감))
seq1 = seq(1, 10, 3)
seq1
seq(1,1000, 0.5)
# rep(시작:종료, 반복할 횟수)
rep(1:5,3)
# rep(시작:종료, each=각데이터별로 반복할 횟수)
rep(1:5, each=3)
# 백터 데이터 처리 함수
# union(vec1, vec2) : 두개의 백터 데이터를 합집합처리
union(vec1, vec2)
x = c(1,3,5,2)
y = c(2,4,6)
union(x,y)
# intersect(vec1, vec2) :  두개의 백터 데이터의 교집합
intersect(x,y)
# setdiff(vec1,vec2) : 두개의 백터 데이터의 차집합
setdiff(vec1,vec2)
# 벡터 변수 지정
v1 = c(33, -5, 20:23, 12, -2:3)
v2 = c("호날두", "메시", "네이마르")
v3 = c(T, TRUE, FALSE, T, TRUE, F, T)
v4 = c(33, -5, 2:023, 12, "4")
sum(v4)
numv4 = as.numeric(v4)
sum(numv4)
# 한 줄에 명령문 두번 이상 사용
v1; mode(v1)
v2; mode(v2); class(v2);
v3; mode(v3); class(v3);
# 벡터로 컬럼명과 데이터 지정
age = c(20, 25, 30)
age
names(age) = c("호날두", "메시", "네이마르")
age
# names(벡터) : 벡터의 컬럼명을 지정
# 벡터의 데이터 변수 삭제
# 변수명 = NULL
age = NULL
age
mode(age)
class(age)
# 벡터의 각각의 데이터 접근 방법
# 벡터명[index번호] : 벡터에서 쓰이는 index는 1부터 시작
# 벡터명[시작index번호:종료index번호] : 특정 범위의 벡터를 호출
v1[1:5]
v1[1]
v2[1]
v2[1,2]
v2[2]
v2[1:2]
# 벡터의 크기 : length(벡터명)
length(v1)
length(v2)
# 벡터의 범위가 10부터의 크기보다 5개 작은 범위
v5 = c(1:50)
v5[10:length(v5)-5]
v5
v5[10:(length(v5)-5)]
# 백터의 범위 : 백터명[시작:마지막]
# 벡터으를 선언할 때 , 를 사용할 수 있는 것과
# 백터의 범위의 백터를 가져올 때는 , 를 이용하지 않는다.
v6 = c(1:5, 9, 10)
v6
v6[1:length(v6)]
v6[1,6] # 불가
v6[4:6]
v6
v6[-2]
v6[-1:-4]
v6[-5:-7]
#벡터명[-c(범위)] : 해당 내용을 제외 처리
v6[-c(1:3)]
#벡터명[C(범위)] : C(범위) => 해당벡터의 index 위치지정
v1
v1[c(2:3,5)]
v1[seq(1,10,2)]
install.packages("RSADBE")
library(RSADBE)
data()
data(Severity_Counts)
# str(데이터 셋) : 데이터 셋의 구조를 나타내줌
str(Severity_Counts)
str()
Severity_Counts
Severity_Counts[1]
#2 matrix : 동일 데이터 타입 갖는 2차원 배열
# 생성 함수 : matrix(), rbind(), cbind()
# 다항함수 적용 : apply()
# 1) 백터를 이용해서 matrix 생성
m1 = matrix(c(1:6))
m1
# matrix(백터) : 백터 내용을 행 단위로 리스트 처리
# nrow : 행의 갯수 지정
# matrix(백터, nrow=행의 갯수)
m2 = matrix(c(1:6), nrow=3)
m2
# byrow : T/F 행우선 리스트 처리
# byrow = T : 속성에 행우선 행렬 객체 생성
# matrix(백터, nrow=행의갯수, byrow=T/F)
m3 = matrix(c(1:10), nrow=2, byrow = T)
m3
# rbind() : 행묶음으로 행렬 객체를 만들어 주기
# cbind() : 열묶음으로 행렬 객체를 만들어 주기
x1 = c(5,40, 50:52)
x2 = c(30,5,6:8)
rbind(x1,x2)
cbind(x1,x2)
# matrix의 여러 속성값을 이용한 행렬 객체
# matrix(data, nrow, ncol, byrow, dimnames)
m3 = matrix(c(1:10), ncol=2)
m3
mode(m3)
class(m3)
# matrix 객체의 데이터를 접근하는 방법
# 메트릭스명[행의 index(1~), 열의 인덱스(1~)]
# 메트릭스명[1,] : 해당 메트릭스의 1행 전체를 저장
# 메트릭스명[,2] : 해당 메트릭스의 2열 전체를 저장
m3
m3[1,2]
m3[1,]
m3[2,]
m3[2,2]
m3[,1]
m3[,2]
m3[1]
m3[2]
m3[3]
m3[5,1]
m3
m3[1,1]
m3[1,3]
m3[1,]
m3[2,]
m3[,1]
# 매트릭스명[행index, 백터로 범위 지정] : 특정 행의 백터 범위내 열을 호출
m3[1, c(1:3)]
m3[1, seq(1,5,2)]
m3[2,c(2:5)]
m3[-1]
m3[-2,]
m3[,-1]
m3[-1,-1]
m3[-3]
n3[,-3]
m3[,-3]
# 매트릭스명[행백터범위, 열백터범위] : box범위 행열 범위의 데이터를 가져옴
m3[c(1:2), c(2:3)]
ex = matrix(21:40, nrow=4, byrow=T)
ex
ex[3,]
ex[,2]
ex[c(1:2),c(3:5)]
ex[3,3]
# 행렬 객체 자료 처리 함수
# length(매트릭스명) : 매트릭스 자료의 크기
length(m3)
# ncol(매트릭스명) : 열의 갯수
ncol(m3)
# nrow(매트릭스명) : 행의 갯수
nrow(m3)
m3
# apply() 함수
# 행렬구조의 자료를 처리하는데 함수를 통해서 원하는 데이터를 로딩하기 위하여 사용된다.
# apply(행렬객체, margin(1-행/2-열), 적용할 함수)
# 적용할 함수 : max, min, mean, 사용자 정의
# ex) 지정한 메트릭스의 행단위(1)의 최대값을 구하기
m3
apply(m3, 1, max)
apply(m3, 2, max)
apply(m3, 1, min)
apply(m3, 1, mean)
# 사용자 정의 함수 처리하기
f = function(x){}
f = function(x){
  x*c(1,2,3)
}
x = matrix(c(1:9), nrow=3, ncol=3)
x
result = apply(x,2,f)
result
plot(women)
x
result
# colnames(매트릭스명) = 백터명 : 컬럼명을 지정
colnames(x) = c("첫번째", "두번째", "세번째")
x = matrix(c(1:9), nrow=3, ncol=3, byrow=T)
x
# Array : 동일 데이터 타입을 갖는 다차원 배열
d = c(1:12)
d
# array(데이터, c(행, 열, 면))
# array(d, c(3,2,2)) : 1~12까지 데이터를 3행, 2열, 2면으로 저장
arr1 = array(d, c(3,2,2))
arr1
arr1[2,2,1] #1면의 2행 2
mode(arr)
mode(arr1)
class(arr1)
data("iris3")
iris3
class(iris3)
help(demo)
demo()
library(RSADBE)

# List : 서로 다른 데이터 구조
# 성격이 다른 데이터(백터, 행렬, 데이터프레임 등 모든 데이터)
# 1차원 리스트 : 1개의 key = 1개의 원소값을 할당
# 1개의 key값을 생략 처리
# list("lee", "이순신", 95, "hong", "홍길동", 85)
list1 = list("크리스티아누", "호날두", 32, "리오넬", "메시", "30")
list1
# list 이용 key, value 반환
list1[1]
list1[[1]]
# key 이용 value 반환
list1[[1]][1]
# list구조 제거 = vector
vec_list = unlist(list1)
vec_list
# 1차원 리스트 : 1개의 key = 2개 이상의 원소(key 생략)
help(list)
example(list)
num <- list(c(1:5), c(6:10))
num
num[1] # 첫번째 list(key+value)
num[2] # 두번째 list(key+value)
num[[1]][3]
# 1차원 리스트 : 1개 key = 2개 이상 원소(key 지정 --> 매핑한 다수값)
num2 <- list(first=c(1:5), second=c(6:10)) # key=value 형태로 저장
num2
plot(first~second, data=num2)
lm(first~second, data=num2)
num2
num2[[1]]
num2[1]
num2[2]
num2$first[3]
num2$first
num2$second
num2$second[c(2:4)]
# list :  key, value 형태 저장
member <- list(name=c("호날두", "네이마르", "메시"), age=c(32, 26, 30), 
               address=c("포르투갈", "브라질", "아르헨티나"), gender=c("남자", "남자", "남자"), 
               team=c("레알 마드리드", "바르샤", "바르샤"))
member
str(member)
# member에 name이라는 key에 할당되어 있는 두번째 데이터 출력
member$name[2]
member$age
# list 원소에 데이터 할당하기
member$age <- c(50, 51, 52)
member$age
member$name[3] <-"수아레즈"
member$name
# member에 key를 새로 생성하고 해당 key에 데이터값을 할당
str(member)
#position이라는 key와 value값 할당, age라는 key 삭제
member$position <- c("공격수", "공격수", "공격수")
str(member)
example(list)
# 원소 제거는 해당 key에 NULL 할당 처리
member$age <-NULL
str(member)
member$address[3] <- "우르과이"
str(member)
