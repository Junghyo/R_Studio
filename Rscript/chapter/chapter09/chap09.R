# oracle DB에 연결하기 위한 package설치
install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")
library(DBI)
Sys.getenv()
library(rJava)
library(RJDBC)

# r 코드를 이용한 oracle data 추출
# dbConnect(Driver, URL, id, password)

# 단계 1 : driver 설정
driver <- JDBC("oracle.jdbc.driver.OracleDriver", 
               "C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar")
# 단계 2-1 : url 설정
url <- "jdbc:oracle:thin:@//192.168.0.179:1521/XE"
# 단계 2-2 : db 연동(driver, url, id, password)
conn <- dbConnect(driver, url, "scott", "tiger")

# record 검색 (test table)
query <- "SELECT * FROM TEST"
tb <- dbGetQuery(conn, query)
tb
str(tb) # 4개 변수, 2개 관측치
mode(tb); class(tb) # list, data.frame

# 단계 1 : PWD 컬럼기준 내림차순 정렬
query <- "SELECT * FROM TEST ORDER BY PWD DESC"
dbGetQuery(conn, query)

# 단계 2 : 데이터 추가
query <- "INSERT INTO TEST VALUES('yoda', '1111', '요다', 45)"
dbGetQuery(conn, query)

# 단계 3 : 조건 검색
query <- "SELECT * FROM TEST WHERE AGE >= 40"
dbGetQuery(conn, query)

# 단계 3 : 데이터 수정
query <- "UPDATE TEST SET ID='admin', NAME='admin' WHERE ID='yoda'"
dbGetQuery(conn, query)

# 단계 4 : 데이터 삭제
query <- "DELETE FROM TEST WHERE NAME='admin'"

# mariaDB PORT : 3306, SERVER NAME : MYSQL

# mariaDB 연동
# 단계 1 : driver 설정 및 url 설정
driver <- JDBC(driverClass="com.mysql.jdbc.Driver",
               classPath="C:/Program Files/MariaDB 10.3/mysql-connector-java-5.1.42/mysql-connector-java-5.1.42/mysql-connector-java-5.1.42-bin.jar")

url <- "jdbc:mysql://192.168.0.179:3306/work"

# 단계 2 : db연동(driver, url, id, password)
conn <- dbConnect(driver, url, "yoda", "tiger")
dbListFields(conn, "goods")

# table의 record 조회
query <- "SELECT * FROM GOODS"
goods <- dbGetQuery(conn, query)
goods

# 파일(csv) 자료를 db테이블에 덮어쓰기
# dbWriteTable(db연결객체, "테이블명", 데이터프레임)
recode <- read.csv(file.choose())
dbWriteTable(conn, "goods", recode)
recode

# db 연결 종료
dbDisconnect(conn)



