# 4장 연습문제

# 1. 다음 조건에 맞게 client data.frame을 생성하고 조건에 맞게 처리하시오.
name <- c("유관순", "홍길동", "이순신", "신사임당")
gender <- c("F", "M", "M", "F")
price <- c(50, 65, 45, 75)
# 1-1. 다음 3개의 vector 객체를 이용하여 client data.frame 생성
client <- data.frame(name, gender, price)
client
mode(client); class(client) # list, data.frame
# 1-2 price 변수 값이 65만원 이상이면 "Best" 미만이면 "Normal"로 result 변수에 추가
client$result <- ifelse(client$price>=65,"Best","Normal")
client
# 1-3 result 변수를 대상으로 빈도수 구하기
table(client$result)

# 2. 다음 vector(EMP)는 '입사년도이름급여'순으로 사원의 정보가 기록된 데이터이다.
# 이 데이터를 이용하여 다음과 같은 출력결과가 나타나도록 함수를 정의하시오.
emp <- c("2014홍길동220", "2002이순신300", "2010유관순260")
emp_pay <- function(x){
  process1 <- str_extract_all(x, "[가-희][0-9]{3}")
  process2 <- str_extract_all(process1, "[0-9]{3}")
  sal <- as.numeric(process2)
  mean <- mean(sal)
  cat("전체 급여 평균 : ",mean,"\n")
  name <- str_extract_all(x, "[가-희]{3}")
  emp_df <- data.frame(name,sal)
  for(i in 1:3){
    if(emp_df$sal[i]>=260){
      cat(emp_df$name[i],"=>",emp_df$sal[i],"\n")
    }
  }
}
emp_pay(emp)
name <- str_extract_all(emp, "[가-희]{3}")
name <- unlist(name)
process1 <- str_extract_all(emp, "[가-희][0-9]{3}")
process2 <- str_extract_all(process1, "[0-9]{3}")
sal <- as.numeric(process2)
df <- data.frame(name,sal)
for(i in 1:3){
  if(df$sal[i]>=260){
    cat(df$name[i],"=>",df$sal[i])
  }
}
# 3. 함수 y = f(x)에서 x의 값이 a에서 b까지 변할 때 △x=b-a 를 x 의 증분이라고 하며 
# △y=f(b)-f(a)를 y의 증분이라고 한다. 여기서 평균변화율 △y/△x =f(b)-f(a)/b-a이다
# 3-1 함수 f(x) = x³+4에서 x의 값이 1에서 3까지 변할 때, 평균변화율을 구하는 함를 작성하시오.
# 평균변화율 : 31-5/2 =13




# 4. RSADBE package에서 제공하는 Bug_Metrics-Software 데이터 셋을 대상으로 소프트웨어 발표 후
# 행단위 합계와 열 단위 평균을 구하고 컬럼단위로 요약통계량을 구하시오.
require(RSADBE)
Bug_Metrics_Software
str(Bug_Metrics_Software) # 5행, 5열, 2면
data("Bug_Metrics_Software")
# 행 단위 합계
rowSums(Bug_Metrics_Software[,,2])
# 열 단위 평균
colMeans(Bug_Metrics_Software[,,2])
summary(Bug_Metrics_Software[,,2])
describe(Bug_Metrics_Software[,,2])
