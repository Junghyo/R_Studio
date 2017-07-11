# 연산자
# 산술연산자 : +, -, *, /, %%, ^, ** : 사칙연산, 나머지연산, 제곱 계산
# 관계연산자 : ==, !=, >, >=, <, <= : 동등비교, 크기비교
# 논리연산자 : &, |, !, xor() : 논리곱, 논리합, 부정, 배타적논리합

# 산술연산자
num1 <- 100
num2 <- 20
result <- num1+num2 # 덧셈
print(result) # 120
result <- num1-num2 # 뺄셈
print(result) # 80
result <- num1/num2 # 나누기
print(result) # 5
result <- num1*num2 # 곱하기
print(result) # 2000
result <- num1%%num2 # 나머지연산
print(result) # 0
result <- num1^2 # 제곱(100의 2제곱) num1**2와 같음
print(result) # 10000
result <- sqrt(num1) # 제곱근
print(result) # 10

# 관계연산자 - 동등비교
boolean <- num1 == num2 # 두 변수값이 같은지 비교
boolean # FALSE
boolean <- num1 != num2 # 두 변수값이 다른지 비교
boolean # TRUE
# 관계연산자 - 크기비교
boolean <- num1 > num2 # num1이 더 큰지 비교
boolean # TRUE
boolean <- num1 <= num2 # num2가 크거나 같은지 비교
boolean # FALSE

# 논리연산자
logical <- num1 >= 50 & num1 <= 10 # 두 관계식이 옳은지 판단
logical # FALSE
logical <- num1 >= 50 | num1 <= 10 # 두 관계식 중 하나라도 옳은지 판단
logical # TRUE
logical <- num1 >= 50 # 관계식 판단
logical # TRUE
logical <- !(num1>=50) # 괄호 안의 관계식에 대한 부정
logical # FALSE

# 배타적 논리합 : 두 논리적인 값이 서로 상반된 경우 TURE를 반환
x <- TRUE; y <- FALSE
xor(x,y) # TRUE

# 조건문
# if()
# if(조건식){ 참인 경우 처리문 }else{ 거짓인 경우 처리문 }
x <- 10; y <- 4;
if(x*y>=40){
  cat("x*y의 결과는 40이상입니다.\n")
  cat("x*y=",x*y)
}else{
  cat("x*y의 결과는 40미만입니다. x*y=",x*y,"\n")
}

# 키보드로 입력받은 점수를 대상으로 학점 구하기
score <- scan()
50
result <- "노력"
if(score>=80){
  result <- "우수"
}
cat("당신의 학점은 ",result, score) # 학점 결과 출력

# if~else 형식으로 학점 구하기
score <- 80
if(score >= 90){
  grade <- "A"
}else if(score >= 80){
  grade <- "B"
}else if(score >= 70){
  grade <- "C"
}else if(score >= 60){
  grade <- "D"
}else{
  grade <- "F"
}
cat("당신의 성적은 ", score, "점입니다. 성적은 ", grade, "입니다.")

# ifelse() : 3항 연산자와 유사
# 형식 : ifelse(조건식, 참인 경우 처리문, 거짓인 경우 처리문)
ifelse(score>=80, "우수", "노력") # 80 이상일 경우 우수, 아니면 노력
ifelse(score<80, "노력", "우수") # 80 미만일 경우 노력, 아니면 우수

# ifelse() 응용
getwd()
setwd("C:/R_Studio/Part-I")
excel <- read.csv(file="excel.csv", header=T)
excel
q1 <- excel$q1
q1
ifelse(q1>=3, sqrt(q1), q1) # q1값이 3이상일 경우 sqrt() 적용
# 논리 연산자 적용
ifelse(q1>=2 & q1<=4, q1^2, q1) # q1값이 2~4면 2제곱 적용

# switch() : switch(비교문, 실행문1, 실행문2, 실행문3)
switch("name", id="real", age=32, pwd="1234", name="Ronaldo") # Ronaldo
switch("name", id="real", age=32, pwd="1234", name="Ronaldo", name="Messi") # Ronaldo
empname <- scan(what="")
"ronaldo"
"messi"

empname
switch(empname, ronaldo=500, messi=400, rooney=300, neymar=350)

# which() 
name <- c("kim", "lee", "choi", "park")
which(name=="kim") # 해당값이 있는 데이터의 index 반환
no <- c(1:5)
name <- c("hong", "lee", "park", "choi", "seo")
score <- c(50, 60, 70, 80, 100)
exam <- data.frame(no, name, score)
exam
which(exam$name=="lee") # 2
exam$name[2] # lee
exam[2,] # 2, lee, 60
which(exam$score==100) # 5
exam$score[5] # 100
exam[5,3] # 100

# for() : for(변수 in 변수){ 실행문 }

# i*3을 10회 반복. 3,6,9,....,30을 10회
i <- c(1:10)
for(n in i){
  print(i*3)
  print(n)
}

# 짝수값만 출력하는 반복문
for(n in i){
  if(n%%2==0) print(n*2)
}

# 홀수값만 출력하는 반복문
for(n in i){
  if(n%%2==1) print(n)
}

# 짝수일 경우 넘기고 홀수일 경우 출력하는 반복문
for(n in i){
  if(n%%2==0){
    next
  }else{
    print(n)
  }
}
# next : 다음문장 skip -> 반복문 계속(continue 키워드와 동일)

# 변수의 컬럼명 출력
names <- c(names(exam))
names
for(n in names){
  print(n)
}

# vector 데이터 사용

i <- 1
for(n in score){
  cat(name[i]," : ",n,"\n")
  i <- i+1
}

# while() : while( 조건 ){ 실행문 }
i = 1
while(i<100){
  i<-i+1 # 프로세스가 진행될때마다 1씩 증가
  print(i) # i<100 프로세스가 끝날때까지 출
}

# repeat() : repeat{ 탈출조건 }
cnt <- 1
repeat{
  print(score)
  score <- score+1 # score에 계속 1씩 더함
  if(score>100) break # score가 모두 100이 넘으면 탈출
}

# 사용자 정의 함수
f1 <- function(){
  cat("매개변수가 없는 함수")
}
# 함수 호출
f1()

f2 <- function(x){
  cat("받은값:",x,"\n")
  cat(x,"*3=",x*3)
}
f2(10)
f2(30)

f3 <- function(x,y){
  add <- x+y
  return(add)
}
f3(10,20)
f3(20,40)
f3(T,F) # T=1, F=0으로 처리

# 기본 함수를 이용하여 요약통계량과 빈도수 구하기
# 단계 1 : 파일 불러오기
getwd()
test <- read.csv(file="test.csv", header=T)
str(test) # 5개의 변수, 402개의 관측치
mode(test); class(test); # list, data.frame
head(test)
# 단계 2 : 요약 통계량
summary(test) # 변수별 요약통계량. 최소값, 1사분위수, 중앙값, 평균값, 3사분위수, 최대값
# 단계 3 : 특정 변수 빈도 구하기
table(test$A) # A변수 대상 빈도 구하기 - 5점 척도(만족도 조사)
# 단계 4 : 각 칼럼 단위 빈도수와 최대값/최소값 계산 함수 정의
data_pro <- function(x){
  # 컬럼 수 만큼 반복
  for(idx in 1:length(x)){
    cat(idx, "번째 컬럼의 빈도분석 결과")
    print(table(x[idx]))
    cat("\n")
  }
  for(idx in 1:length(x)){
    f <- table(x[idx])
    cat(idx, "번째 컬럼 요약\n")
    cat("가장 많이 나온 값\n")
    cat("최대빈도값=",which.max(f),":최소빈도값",which.min(f),"\n")
    cat("해당값이 얼마나 많이 나오고 얼마나 적게 나왔는가?\n")
    cat(idx, "번째 컬럼의 최대빈도수:최소빈도수\n")
    cat("max=",max(f),": min=",min(f),"\n")
  }
}
data_pro(test)
which.max(table(test$A)) # A변수의 최대빈도값 찾기
max(table(test$A)) # A변수의 최대빈도수 찾기
which.min(table(test$A)) # A변수의 최소빈도값 찾기
min(table(test$A)) # A변수의 최소빈도수 찾기
max(test$A) # A 변수의 최대값
min(test$A) # A 변수의 최소값
# 말이 굉장히 복잡한데 최대빈도값은 빈도가 가장 많이 일어난 데이터 값을 말하며
# 빈도수는 해당 데이터 값이 몇번이 나왔는가 이다.
# 최대값, 최소값은 해당 변수의 최대값과 최소값을 말한다.

# 분산과 표준편차를 구하는 함수 정의
# 분산 : 통계에서 변량(데이터)이 평균으로부터 떨어져 있는 정도를 나타내는 값. 
# 표본분산 : var <- sum((데이터값-산술평균)^2)/(데이터수-1)
# 표본분산 : var <- sum((데이터값-산술평균)^2)/(데이터수)
# 표준편차 : sqrt(var)

# descirbe를 사용하기 위한 package
require(psych)
describe(test) # 표준편차(sd) : 0.89(A), 0.96(B), 1.02(C), 0.78(D), 1.00(E)

# 분산 및 표준편차 함수
var_sd <- function(x){
    var <- sum((x-mean(x))^2)/(length(x)-1) # 표본분산
    sd <- sqrt(var) # 분산
    cat("표본분산:",var,"\n")
    cat("표본표준편차:",sd)
}  
var_sd(test$A) # 분산 : 0.605, 표준편차 : 0.888
var_sd(test$B) # 분산 : 0.922, 표준편차 : 0.960
var_sd(test$C) # 분산 : 1.034, 표준편차 : 1.017
var_sd(test$D) # 분산 : 0.605, 표준편차 : 0.778
var_sd(test$E) # 분산 : 0.991, 표준편차 : 0.995
# descirbe에 출력된 표준편차와 일치한다.

# 분산 및 표준편차 함수 ex2
describe(women) # 표준편차 : 4.47(height), 15.50(weight)
var_sd2 <- function(x){
  var <- round(sum((x-mean(x))^2)/(length(x)-1),2)
  sd <- round(sqrt(var),2)
  cat("표본분산:",var,"\n")
  cat("표본표준편차:",sd)
}
var_sd2(women$height) # 분산:20, 표준편차:4.47
var_sd2(women$weight) # 분산:240.21, 표준편차: 15.5

# 피타고라스와 구구단 함수 정의
# 피타고라스 식 정의 : a²+b²=c²
pytha <- function(s,t){
  a <- s^2 - t^2
  b <- 2*s*t
  c <- s^2+t^2
  cat("피타고라스의 정리\n")
  cat("3개의 변수:",a,b,c)
}
pytha(2,1)

# 구구단 출력 함수
gugu <- function(dan, grade){
  for(x in dan){
    cat("###",x,"단 ###\n")
    for(y in grade){
      cat(x,"x",y,"=",x*y,"\n")
    }
    cat("\n")
  }
}
dan <- c(2:9)
grade <- c(1:9)
gugu(dan,grade)

# 결측치 데이터를 대상으로 평균 구하기
# 단계 1 : NA 포함 vector 생성
x <- c(10,20,5,4,40,7,NA,6,3,NA,2,NA)
mean(x)  # NA
# 단계 2 : 결측치 데이터 처리 함수
na <- function(x){
  # 1차 NA 제거 후 평균
  print(x)
  print(mean(x, na.rm=T))
  
  # 2차 NA를 0으로 대체
  x_2 <- ifelse(!is.na(x),x,0)
  print(x_2)
  print(mean(x_2))
  
  # 3차 NA를 평균으로 대체
  x_3 <- ifelse(!is.na(x),x,round(mean(x, na.rm=T), 2))
  print(x_3)
  print(mean(x_3))
}
na(x)


# 몬테카를로 시뮬레이션
# 동전 앞면과 뒷면의 난수 확률분포의 기대확률 모의실험
# 단계 1 : 동전 앞면과 뒷면의 난수 확률분포 함수 정의
coin <- function(n){
  r <- runif(n, min=0, max=1 )
  result <- numeric()
  for(i in 1:n){
    if(r[i]<=0.5){
      result[i] <- 0 # 앞면
    }else{
      result[i] <- 1 # 뒷면
    }
  }
  return(result)
}
coin(10)
# 단계 2 : 몬테카를로 시뮬레이션 함수 정의
montaCoin <- function(n){
  cnt <- 0
  for(i in 1:n){
    cnt <- cnt + coin(1) # n 시행 회수만큼 동전 함수 호출
  }
  result <- cnt/n # 동전 앞면과 뒷면의 누적 결과를 시행 횟수(n)로 나눈다.
  return(result)
}
montaCoin(10)
montaCoin(100)
montaCoin(1000)
montaCoin(10000)
# 시행 횟수(표본 수)가 커질수록 0.5에 근사한다.

# 기술통계량 처리 관련 내장함수
x <- seq(1,50,3)
min(x) # 최소값 구하는 함수 : 1
max(x) # 최대값 구하는 함수 : 49
range(x) # vector 데이터값 범위를 구하는 함수 : 1, 49
mean(x) # 평균값 : 25
median(x) # 중앙값 : 25
sum(x) # 데이터 합계 : 425
sort(x) # 데이터 정렬
order(x) # 정렬된 값의 index를 보여주는 함수
rank(x) # 정렬된 값의 순위를 보여주는 함수
sd(x) # 표준편차 : 15.14926
summary(x) # 기초통계량 : 최소, 1사분위수, 중앙값, 평균값, 3사분위수, 최대값
table(x) # 빈도수
sample(x,y) # x의 범위에서 y만큼 sample 데이터를 생 

# 행 단위, 열 단위 합계와 평균 구하기
# 1단계 : 데이터 셋 불러오기
require(RSADBE)
data(Bug_Metrics_Software)
str(Bug_Metrics_Software) # 3개의 list, 5행 5열 2면
nrow(Bug_Metrics_Software) # 행 : 5
ncol(Bug_Metrics_Software) # 열 : 5
mode(Bug_Metrics_Software); class(Bug_Metrics_Software) # numeric, xtabs/table
# 2단계 : 소프트웨어 발표 전 행 단위 합계
rowSums(Bug_Metrics_Software[,,1]) # 소프트웨어별 버그수 합계
rowMeans(Bug_Metrics_Software[,,1]) # 소프트웨어별 버그수 평균
# 3단계 : 소프트웨어 발표 전 열 단위 합계
colSums(Bug_Metrics_Software[,,1]) # 버그 종류별 합계
colMeans(Bug_Metrics_Software[,,1]) # 버그 종류별 평균
# 4단계 : summary() 함수 이용 요약 통계량
summary(Bug_Metrics_Software[,,1])
describe(Bug_Metrics_Software[,,1])

# 기술통계량 관련 내장함수 ex
# 이산형 : 정수(사람 수 , 책 수),
# 연속형 : 실수(3.5m, 7.2kg). 
# 
# 이산형: 좋아 하는지 싫어하는지?(Do you love me?)
# 연속형 : 얼마나 좋아 하는지(How much do you love me?)
# 
# 이산형 : 서열이나 순위,속성, 그룹 (성별: 남 / 녀 , 종교 : 천주교, 기독교, 불교)
# 연속형 : 양적인 의미 (집평수, 몸무게, 키, 시험점수 )

# 난수와 확률분포 관계
# 단계 1 : 정규분포(연속형)의 난수 생성 : rnorm(n, mean, sd)
pdf("C:/R_Studio/Rscript/chapter/chapter04/dist.pdf")
x <-rnorm(1000, mean=0, sd=1)# 평균0, 분산1인 정규분포를 따르는 난수 1000개 생성
hist(x, prob=T, main="Normal Distribution[mu=0, sigma=1]") # 표준정규분포 히스토그램
curve(dnorm(x), add=T, col="red")
# 단계 2 : 균등분포(연속형)의 난수 생성 : runif(n, min, max)
x <- runif(100,min=0,max=1) # 0 < n < 1 균등분포 연속형
hist(x, prob=T, main="Uniform Distribution on [0,1]")
curve(dunif(x), add=T, col="red")

# 단계 3 : 이항분포(이산형) 난수 생성 : 정규분포와 같은 이상적인 분포형이지만
# 연속형이 아닌 이산변량을 갖는다.
# rbinom(n, size, prob) : random binomial distribution. 독립적 n회 반복
# 평균은 np, 분산은 np(1-p)
# B(n, p) : n은 size, p는 prob 
rbinom(20, 1, 0.5) # 0 또는 1의 이산변량 대상 0.5확률로 20개 선정
rbinom(20, 2, 0.5) # 0,1,2의 이산변량 대상 0.5확률로 20개 선정
rbinom(20, 10, 0.5) # 0~10사이의 이산변량 대상 0.5확률로 20개 선정
y <- rbinom(1000,5,1/6) # 0~5 사이의 이산변량 대상 1/6확률로 1000개 선정
hist(y, prob=T, main="Binomial Distribution[n=1000, B(5,1/6)]")
points(0:5,dbinom(0:5,5,1/6), type="h", lwd=3)
points(0:5,dbinom(0:5,5,1/6), type="p", lwd=3)
dev.off()

# 단계 4 : 종자 값으로 동일한 난수 생성
# 형식 : set.seed(임의의 정수)
rnorm(5,0,1) # 매번 실행할 경우 임의의 난수 생성
set.seed(123) # 종자값이 123이면 항상 동일한 난수 생성
rnorm(5,0,1)
set.seed(345) # 종자값이 345면 항상 동일한 난수 생성
rnorm(5,0,1)

# 수학관련 내장함수
x <- c(-1.25, 0, -3.44, -5.57, 3.33, 6.75, 5)
x
y <- c(1,3,5,-7,10,4,-12)
y
abs(x) # 절대값
sqrt(x) # 제곱근(음수는 NaN 표시)
ceiling(x) # 올림
floor(x) # 버림
round(x) # 반올림
factorial(x) # 계승값 ex) 5 -> 5*4*3*2*1=120
which.min(x) # vector 내 최소값의 index
which.max(x) # vector 내 최대값의 index
pmin(x,y) # x,y 의 vector길이가 같을때 서로 같은 index에서 최소값을 반환
pmax(x,y) # x,y 의 vector길이가 같을때 서로 같은 index에서 최대값을 반환
prod(x) # vector 데이터들의 곱
cumsum(y) # 누적합
cumprod(x) # 누적곱
cos(x); sin(x); tan(x) # 삼각합수
log(x) # 자연로그(밑수가 e=2.7182818)
log10(10) # 10을 밑으로 하는 일반로그함수(e^x)

# 행렬연산 관련 내장함수
x <- c(1:10)
y <- c(11:20)
z <- c(21:30)
df <- data.frame(x,y,z)
df
mt <- matrix(c(1:4),2,2)
mt2 <- matrix(c(5:8),2,2)
ncol(df) # 열 갯수
nrow(df) # 행 개수
t(df) # 전치행렬(열이 행으로, 행이 열로 바뀜)
cbind(df,a=c(31:40)) # 열 추가
rbind(df, c("a","b","c")) # 행 추가
diag(mt) # 대각행렬
det(mt) # 행렬식
apply(df,2,sum) # 행(1) 또는 열(2)에 함수 적용
solve(mt) # 역행렬
eigen(mt) # 정방행렬을 대상으로 고유값을 분해
svd(df) # m x n 행렬을 대상으로 특이값을 분해
mt
mt%*%mt # 두 행렬의 곱을 구하는 수식
mt*mt # TODO : 왜 저렇게 하는지?

# 집합관련 내장함수
x <- c(1,3,5,7,9)
y <- c(3,5,4,2) 
union(x,y) # 합집합(중복된 숫자는 하나만 표시)
c(x,y) # 합집합으로도 이용 가능하나 중복된 문자는 그대로 표시
setdiff(x,y) # 차집합
intersect(x,y) # 교집합
setequal(x,y) # x,y의 동일성 검사
x %in% y # x의 원소가 y의 원소인지 검사

