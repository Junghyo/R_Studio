install.packages(c("rJava", "DBI", "RJDBC"))
library(DBI)
library(rJava)
library(RJDBC)
# 드라이버 설정
driver <- JDBC("oracle.jdbc.driver.OracleDriver",
               "C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar")
# url 설정
url <- "jdbc:oracle:thin:@//192.168.219.116:1521/XE"

# 연결
conn <- dbConnect(driver, url, "scott", "tiger")

# query문
query <- "SELECT * FROM EMP"
# query문 연결
emp <- dbGetQuery(conn, query)
emp

# gsub("제거할 문자", "변경할 문자", "제거대상컬럼")
emp$HIREDATE <- gsub(" 22:23:21", '', emp$HIREDATE)
emp$HIREDATE <- gsub(" 00:00:00", '', emp$HIREDATE)

str(emp) 
# $ HIREDATE: chr
# $ DEPTNO  : num
# $ JOB     : chr

# hiredate date로 변환
emp$HIREDATE <- as.Date(emp$HIREDATE)

# deptno, job을 factor화
emp$JOB <- as.factor(emp$JOB)
emp$DEPTNO <- as.factor(emp$DEPTNO)

str(emp) #  
# $ HIREDATE: Date
# $ JOB     : Factor w/ 6 levels
# $ DEPTNO  : Factor w/ 3 levels

# statistics value
summary(emp)

# plot - ggvis, barplot....
par(mfrow=c(1,1))
library(ggplot2)
library(ggvis)
emp %>% 
  ggvis(~JOB, ~SAL, fill=~DEPTNO) %>%
  layer_bars()

barplot(table(emp$DEPTNO))

dbDisconnect(conn)
