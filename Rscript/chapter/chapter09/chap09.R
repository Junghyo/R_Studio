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


# 연관어 분석
# 특정 단어와 연관성이 있는 단어들을 선별하여 네트워크 형태로 시각화하는 과정
# 단계 1 : text 파일 가져오기
market <- file(file.choose(), encoding="UTF-8") # Part-II, marketing.txt
market2 <- readLines(market) # 줄 단위 데이터 생성
close(market) # market 메모리에서 제거
head(market2)

# 단계 2 : 줄 단위 단어 추출
lword <- Map(extractNoun, market2)
length(lword)  # 472
lword <- unique(lword) # 중복단어 제거(전체 대상)
length(lword) # 353

lword <- sapply(lword, unique) # 중복단어 제거(줄 단위 대상)
lword

# 연관어 분석을 위한 전처리
# 길이 2~4 문자 길이로 필터링
# 단계 1 : 필터링 함수 생성
filter1 <- function(x){
  nchar(x) <= 4 && nchar(x) >= 2 && is.hangul(x)
}

# Filter()를 이용하여 vector 단위로 필터링 하는 함수 정의
filter2 <- function(x){
  Filter(filter1, x)
}

# is.hangul() : vector를 대상으로 한글 추출
# Filter(f, x) : 함수(f)를 이용하여 vector(x) 필터링 기능
# nchar(x) : vector를 대상으로 문자수 반환

# 단계 2 : 줄 단위로 추출된 단어 전처리
# 길이 1개 이하 또는 5개 이상 제거
lword <- sapply(lword, filter2)
lword

# Transaction 
mode(lword); class(lword) # list, list
# transaction 형식으로 자료구조를 변환해야함
# transaction : 연관분석에서 사용되는 자료 처리 단위

# 단계 1 : package 설치
install.packages("arules")
library(arules)

# 단계 2 : transaction 생성
# as() 사용. 실행결과 transaction 수(행)과 아이템 수(열) 나타남
wordtran <- as(lword, "transactions") # 형식 : as(data, "type")
wordtran
wordtable <- crossTable(wordtran) # 교차표 작성
wordtable

# transaction : 상품거래정보 의미
# item : 상품거래에서 발생하는 상품목록
# 여기서는 lword 한줄을 transaction, 한줄에서 만들어진 단어를 item으로 처리
# crossTalbe() : transaction 객체를 대상으로 동일한 단어끼리 교차테이블 작성

# 단어 간 연관규칙 발견
# apriori() : 연관규칙 알고리즘 적용
#            지지도와 신뢰도를 지정하여 연관규칙 발견
# apriori(data, parameter=NULL, appearance=NULL, control=NULL)
# data : transaction type의 객체
# parameter : 지지도(support), 신뢰도(confidence), 연관단어 최대길이(maxlen)를 인수로 사용 가능
# appearance : 연관규칙을 나타내는 속성 지정
# control : 연관규칙 결과(item)을 정렬(sort)

# 단계 1 : 연관규칙 발견(support: 0.25, confidence:0.05인 경우 59개 규칙 발견)
tranrules <- apriori(wordtran, parameter=list(supp=0.25, conf=0.05))
# [59 rule(s)] done [0.00s].
inspect(tranrules)

# 연관어 시각화
# 연관규칙 결과를 data.frame 또는 matrix로 변경

# 단계 1 : 연관단어 시각화를 위해 자료구조 변경
rules <- labels(tranrules, ruleSep=" ") # 연관규칙 label을 " "로 분
rules
class(rules) # character

# 단계 2 : 문자열로 묶인 연관단어를 행렬구조 변경
rules <- sapply(rules, strsplit, " ", USE.NAMES=F)
rules

# 단계 3 : 행 단위로 묶어서 matrix로 변형
rule_mt <- do.call("rbind", rules)
rule_mt
class(rule_mt)

# 연관어 시각화를 위한 igraph package 설치
install.packages("igraph")
library(igraph)

# edgelist보기
# 연관단어를 정점(Vertex) 형태의 목록으로 제공.
ruleg <- graph.edgelist(rule_mt[c(12:59)], directed=F)
