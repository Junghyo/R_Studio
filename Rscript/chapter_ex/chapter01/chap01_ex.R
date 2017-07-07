# 1장 연습문제
# 1. 현재 작업공간을 확인하고 "C:/Rwork/Part-I"로 변경하시오.
getwd() # 현재 작업공간 확인
setwd("C:/Users/acorn/Documents/Rwork/Part-I") # 작업공간 변경

# 2. 다음 조건에 맞게 name, age, address 변수를 생성하고처리하세요.
# 2.1 각 변수의 특성에 맞게 값을 초기화하고 결과를 확인한다.
name <- "Ronaldo"
name
age <- 32
age
address <- "Portugal"
address
# 2.2 각 변수를 대상으로 자료형을 확인한다.
mode(name)
class(name)
is.character(name)
mode(age)
class(age)
is.numeric(age)
mode(address)
class(address)
is.character(address)

# 3. R에서 제공하는 women 데이터 셋을 다음과 같이 처리하시오.
# 3.1 women 데이터 셋은 어떤 데이터의 모음인가?
# 3.2 women 데이터 셋의 자료형과 자료구조는?
women
str(women)
mode(women) # 자료의 성격(물리적) : lsit
class(women) # 자료 구조의 성격(추상적) : data.frame
mode(women$height); class(women$weight); # 변수의 성격: numeric, numeric
women$weight

# 3.3 plot() 함수를 이용하여 기본 차트 그리기
pdf(file="C:/Users/acorn/Documents/Rwork/women.pdf")
plot(women$weight~women$height) # y축~x축 default
plot(women$weight~women$height, type="o", cex=1.5, pch="+", col="red")
plot(women$height~women$weight, type="l", col="blue")
plot(women, type="h")
plot(women, type="s")
dev.off()

# 4 R에서 제공하는 c()함수를 이용하여 백터를 생성하고 데이터를 처리하시오.
# 4.1 1~100까지 백터 생성
vec1 <- c(1:100)
vec1
# 4.2 백터 평균 구하기
mean(vec1)

# 5 R 프로그래밍 언어의 특징을 2가지만 기술
# 객체지향언어, 고속메모리 처리