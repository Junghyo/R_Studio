# 2장 연습문제

# 1. 다음과 같은 vector 객체를 생성하시오.
# 1-1. vec1 vector 변수를 만들고 "R" 문자가 5회 반복되도록 하시오.
vec1 <- rep("R",5)
vec1
# 1-2. vec2 vector 변수에 1~10까지 3간격으로 연속된 정수를 만드시오.
vec2 <- seq(1,10,3)
vec2
# 1-3. vec3에는 1~10까지 3간격으로 연속된 정수가 3회 반복되도록 만드시오.
vec3 <- rep(vec2, 3)
vec3
# 1-4. vec4에는 vec2~vec3가 모두 포함되는 vector를 만드시오.
vec4 <- c(vec2,vec3)
vec4
# 1-5. vec5 : 25 ~ -15까지 5간격으로 vector 생성(seq함수 이용)
vec5 <- seq(25,-15,-5)
vec5
# 1-6. vec4에서 홀수번째 값만 선택하여 vec6에 할당하시오(첨자 이용)
vec6 <- vec4[seq(1,length(vec4),2)]
vec6

# 2. 다음과 같은 vector를 컬럼으로 갖는 data.frame을 생성하시오.
name <- c("최민수", "유관순", "이순신", "김유신", "홍길동")
age <- c(55, 45, 45, 53, 15) # 연령
gender <- c(1, 2, 1, 1, 1) # 1:남자, 2:여자
gender_f <- factor(gender, levels=c(1,2),labels =c("남자","여자"))
gender_f
job <- c("연예인", "주부", "군인", "직장인", "학생")
sat <- c(3,4,2,5,5) # 만족도
grade <- c("C", "C", "A", "D", "A")
total <- c(44.4, 28.5, 43.5, NA, 27.1) # 총구매금액(NA:결측치)
# 2-1. 위 7개의 vector를 컬럼으로 갖는 user data.frame 생성
user <- data.frame(이름=name, 나이=age, 성별=gender_f, 직업=job, 만족도=sat, 등급=grade, 총구매금액=total)
user
# 2-2. gender 변수를 이용하여 히스토그램 그리기
postscriptFonts() # 지원하는 폰트 확인
pdf.options(family = "Korea1deb") # pdf 한글변환
pdf(file ="C:/Users/acorn/Documents/R_Studio/Rscript/chapter_ex/chapter02/ex2_2.pdf")
plot(user$성별, main="성별 히스토그램") # 나이 히스토그램 hist()는 변수가 숫자여야 하기에 적용이 안됨
plot(user$나이~user$성별, data=user, main="성별 나이 분포") # 성별 나이 
plot(user$만족도~user$직업, data=user, main="직업별 만족도") # 직업별 만족도
dev.off()

# 2-3. user에서 짝수행만 선택해서 user2에 넣기
user2 <- user[seq(2,5,2),]
user2

# 3. Data를 대상으로 apply()를 적용하여 행/열 방향으로 조건에 맞게 통계량을 구하시오.
kor <- c(90, 85, 90)
eng <- c(70, 85, 75)
math <- c(86, 92, 88)
# 3-1. 3개의 과목점수를 이용하여 data.frame 생성
subject <- data.frame(kor, eng, math)
subject
# 3-2. 행/열 방향으로 max()함수를 적용하여 최댓값 구하기
apply(subject, 1, max) # 행 방향. 1행 : 90, 2행 : 92, 3행 : 90
apply(subject, 2, max) # 열 방향. 1열 : 90, 2열 : 85, 3열 : 92
# 3-3. 행/열 방향으로 mean()함수를 적용하여 평균 구하기(소숫점 2자리 표현)
# 힌트 : round(data, 자릿수)
round(apply(subject, 1, mean), 2) # 행 방향
round(apply(subject, 2, mean), 2) # 열 방향
describe(subject)
# 3-4. 행 단위 분산과 표준편차 구하기
apply(subject, 1, sd) # 표준편차
apply(subject, 1, var) # 분산 (표준편차의 제곱)

# 4. 다음의 Data2 객체를 대상으로 정규표현식을 적용하여 문자열을 처리하시오.
Data2 <- c("2017-02-05 수입3000원", "2017-02-06 수입4500원", "2017-02-07 수입2500원")
Data2
require(stringr)
# 4-1. 일짜별 수입을 다음과 같이 출력하시오.
# 출력결과) "3000원" "4500원" "2500원"
str_extract_all(Data2, "[0-9]{4}[가-히]{1}")
# 4-2. 위 vector에서 연속하여 2개 이상 나오는 모든 숫자를 제거하시오.
# 출력결과) "--수입원" "--수입원" "--수입원"
str_extract_all(Data2, "[^0-9]{1,}")
# 4-3. 위 vector에서 -를 /로 치환하시오.
str_replace_all(Data2, "-", "/")
# 4-4. 모든 원소를 쉼표(,)에 의해서 하나의 문자열로 합치시오.
# 힌트 paste(데이터, collapse=",") 함수 이용
paste(Data2, collapse=",")
