demo(persp)
x <- 1
y <- 2
x*y -> z
print(z)
x <- c(1,2,3)
y <- c(2,3,4)
x*y
z <- 9
x*z
a <- c(1,2)
x*a # error 발생. 오브젝트의 길이가 다름
length(x)
length(a)
length(z)
x <- c(1,2,3,4,6)
y <- c("1", "2", "3", "4", "5")
z <- c('how', 'are', 'you', '?')
length(y); length(x)
x*y # error 발생. 이항연산자에 숫자가 아닌 인자가 있음
x
y
z
str(x) # num : 숫자
str(y) # chr : 문자
str(z)
1+2==3 # TRUE : boolean 값
1+2 >3 # FALSE
x
y
x==y # x는 숫자, y는 문자형숫자라도 비교를 해줌

x <- c(1:100)
sum(x)
mean(x)
sum(x)/length(x)
max(x)
min(x)
z <- c(3:15)
z
x[5:10]
x[seq(1,100,2)] # 홀수번째 값 출력
x[seq(2,100,2)] # 짝수번째 값 출력
