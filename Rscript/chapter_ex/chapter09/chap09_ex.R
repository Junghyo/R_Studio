#------------------------------
# R version 3.4.1 (2017-06-30)
#
# @ Author: yoda
# @ Tue Aug 01 18:45:48 2017
# @ Asia/Seoul
#------------------------------

# 9장 연습문제.

# 1. 다음과 같은 단계를 통해서 테이블을 생성하고 SQL문을 이용하여 레코드를 조회하시오
# (DBMS는 자유 선택)

# library 등록 
library(rJava)
library(DBI)
library(RJDBC)

# 드라이브 설정(mariaDB 사용)
driver = JDBC(driverClass ="com.mysql.jdbc.Driver", 
              classPath="C:/Program Files/MariaDB 10.3/mysql-connector-java-5.1.42
              /mysql-connector-java-5.1.42/mysql-connector-java-5.1.42-bin.jar")

# url 설정
url = "jdbc:mysql://192.168.0.179:3306/test"

# db연결 : dbConnect(driver, url, id, password)

# 1-1. 상품정보(GoodsInfo)테이블 생성(SQL PLUS)
query = "CREATE TABLE GOODSINFO(
              상품코드 VARCHAR(50) PRIMARY KEY,
              상품명 VARCHAR(50) NOT NULL,
              가격 INT NOT NULL,
              제조사 VARCHAR(50) NOT NULL)"

dbSendUpdate(con, query)
?dbSendUpdate

# 1-2. 레코드 추가
query = "INSERT INTO GOODSINFO VALUES('1001', '냉장고', 1800000, 'SM')"
dbSendUpdate(con, query)
query = "INSERT INTO GOODSINFO VALUES('1002', '세탁기', 500000, 'LN')"
dbSendUpdate(con, query)
query = "INSERT INTO GOODSINFO VALUES('1003', '냉장고', 2500000, 'HD')"
dbSendUpdate(con, query)

# 1-3 전체 레코드 검색
query = "SELECT * FROM GOODSINFO"
dbGetQuery(con, query)

# 1-4 DB 접속 종료
dbDisconnect(con)
