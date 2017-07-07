num1 <- 100
num2 <- 20
result <-num1!=num2
result
!(num1<=50)
x <- T
y <- F
xor(x,y)
x <- 10
y <- 3
if((z<-x*y) >=40){
  cat("x*y의 결과는 40이상입니다.\n")
  cat("x*y=",z)
}else{
  cat("x*y의 결과는 40미만입니다. x*y=",z,"\n")
}

score <- scan()
result <- "노력"
if(score>=80){
  result <- "우수"
}
cat("당신의 학점은 ", result, score)

if(score>=90){
  result <- "A"
}else if(score>=80){
  result <- "B"
}else if(score>=70){
  result <- "C"
}else if(score>=60){
  result <- "D"
}else{
  result <- "F"
}
score <- c(100,80,60,50)
cat("당신의 학점은 ",result, score)
print(result)
ifelse(score>=80, "우수", "노력")

excel <- read.csv(file.choose(), header=T)
excel
str(excel)
View(excel)
q1 <- excel$q1
q1
ifelse(q1>=3, sqrt(q1),q1)
ifelse(q1>=2&q1<=4, q1^2,q1)
switch("name", id=1, age=32, name="Ronaldo", pwd="1234")
empname <- scan(what="")
empname
mode(empname)
class(empname)
switch(empname, "호날"=250, "호날두"=400, "짱"=200)
mode(excel)
class(excel)
q1
class(q1)
vec = c(1,2,3)
vec
ifelse(q1>=2&q1<=3, "유효등급", "등급판정불가")
