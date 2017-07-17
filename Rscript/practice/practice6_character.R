x <- "what's your name?"
x
y <- character()
y
y2 <- ""
y2
class(y); class(y2);
length(y); length(y2) # 0, 1
y3 <- c("e", "12", "2")
y3
y4 <- character(10)
y4
y4[3] <- "third"
y4[12] <- "twelveth"
length(y4)
y4[11] <- "11"
n <- 3
m <- "3"
is.numeric(n); is.numeric(m) # TRUE, FALSE
is.character(n); is.character(m) # FALSE, TRUE
mode(n); class(n)
mode(m); class(m)
as.character(n)
n

t <- 1:5
t
t2 <- c(1:5, "a")
t2
t3 <- c(1:4, TRUE, FALSE)
t3
class(t3)
t4 <- c(1:4)
t4
class(t4)
t5 <- 1
class(t5)

df1 <- data.frame(n=c(1:4, "a"), letters=c("a", "b", "c", "d", "e"))
df1
str(df1)
mode(df1)
class(df1)

# paste
w <- paste("hi", "man") 
w # [1] "hi man"
paste("hi", "man", sep="") # [1] "himan"
hi<- paste("hi", "Ronaldo")
paste(hi, "What's up?", sep=", ")

# 1학년 10반까지 만들기
paste(1, 1:10, sep="-")
# pi 기본 내장 함수
a <- paste("the value of 'pi' is ", pi, ", endress!")
# 따옴표 없애기
noquote(a)
print(a, quote=F)

# 데이터셋 
mtcars
str(mtcars)
car <- rownames(mtcars)
colnames(mtcars)
car
# 각 행컬럼 길이
nchar(car)
# 가장 긴 행 컬럼 index 찾기
a<-which(nchar(car)==max(nchar(car)))
a
# 가장 긴 행 컬럼
cars[a]

# grep
# grep("포함된 문자", data) : 문자가 포함된 데이터의 index를 반환
car # 자동차 이름
# z가 포함된 데이터의 index를 알고 싶다.
grep("z", car) # 1, 2
# z가 포함된 데이터의 실제 값을 보고 싶다.
car[grep("z", car)]
grep("z", car, value=T)

# 대소문자를 구분한다.
grep("v", car, value=T)
# [1] "Hornet 4 Drive" "Honda Civic"    "AMC Javelin"    "Volvo 142E"    
grep("V", car, value=T)
# [1] "Valiant"    "Volvo 142E"

# 대소문자 둘다 불러오고 싶으면?
grep("[Vv]", car, value=T)
# or
grep("v", tolower(car), value=T)  # tolower() : 데이터를 전부 소문자로 변환
# toyota 차종은?
grep("TOYOTA", toupper(car), value=T)
# [1] "TOYOTA COROLLA" "TOYOTA CORONA" 


library(stringr)
# str_count
str_count(car)==nchar(car) # 각 데이터 문자 길이를 반환
str_count(car, "t") # 각 데이터에 t를 몇개 가지고 있는지
# toyota 차종은 몇개가 있는가?
sum(str_count(tolower(car), "toyota")) # 2개
