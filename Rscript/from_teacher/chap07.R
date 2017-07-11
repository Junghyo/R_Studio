# 데이터 전처리 주요 내용
# ● 데이터 전처리
#     - 데이터 수집
#     - 전처리 : 수집된 자료 중, 분석을 위하여 필요로 하는 데이터로 수정, 제거하는 작업
#                (불필요한 자료, 사용할 수 없는 자료)
#     - 데이터 분석

# ● 전처리 작업에서 Filtering하는 데이터 내용
#     - 결측치 : NA
#     - 극단치 : 중간값을 통계로 나타내는데서 문제가 있는 데이터

# 주요 활용되는 package
# ● 데이터를 통합 : join
#     - plyr package
# ● 열이나 행을 추출, filter, 정렬, 집계
#     - dplyr package : select(), mutate(), summarize()
# ● 긴 형식, 넓은 형식으로 변환

# 전처리 프로세스
# ● 데이터 조회
#     - head(), tail(), names() : 컬럼설정과 보기
#       - attributes() : 열, 클래스, 행이름, str() 구조보기
#       - 데이터셋명$변수(컬럼명)
#       - 데이터셋명["컬럼명"]
#       - 데이터셋명[열의index], 데이터셋명[행index,열index]
#       - 데이터셋명[c(열의idx, 시작idx:마지막idx)]
# ● 결측값(NA) 처리
#       - 결측값이 있을 경우 문제 발생 : sum(), avg() 등 함수 처리시 NA 처리
#       - 결측치 데이터 제거 방법
#       - 결측치가 있는 데이터를 함수를 통해 제거
#           na.omit(특정 데이터셋의 변수-컬럼)
#           ex) price2 <- na.omit(dataset$price) : price변수의 모든 NA를 제거해서 price2에 할당
#       - sum, avg 등 함수에 속성값을 지정
#           na.rm = T : not available remove의 속성을 TRUE로 처리합니다.
#           ex) sum(dataset$price, na.rm=T) : price변수에 NA를 빼고 함수 처리

# ● 극단값 발견과 정제
#       1) 극단값의 원인 : 잘못된 표본 추출, 입력상 오류
#       2) 극단값 발견
#           - 화면상 그래프를 통해 확인 : 히스토그램, 테이블 파이차트를 통해 outlier를 확인
#           ex) gender <- dataset$gender
#               hist(gender), table(gender) : 빈도수 간단하게 비교, pie(gender)
#       3) 정제
#         - 발견된 극단값을 원하는 데이터 범위 안으로 filter처리 - subset() 함수 이용
#         - subset()을 통한 정제
#         subset(param1, param2)
#           param1 : 데이터셋 할당
#           param2 : 정제할 조건처리. 주로 boolean값 할당
#           ex) subset(dataset01, dataset01$gender == 1 | dataset01$gender == 2)
#             : dataset01에 있는 변수 중, gender의 값이 1이거나 2인 값만 가져와서 데이터셋 구성
#         - subset()을 통해 정제된 데이터를 새로운 데이터셋에 할당하여 활용
#             : newdata <- subset(data, data$age >= 20 & data$age <= 65)
#         - 화면상 비교분석 : pie(table(newdata$gender))

# ● 코딩변경 : 변수(컬럼) 추가, 변경
#       - 기존에 있는 데이터도 필요하여, 새로운 변수를 추가하여 처리할 때
#       - 기본형식 : 데이터셋$새로운변수[데이터셋$기존변수의 조건] <- 신규로 할당할 데이터
#           ex) 연령별로 연령에 대한 표시를 해야하는 새로운 변수가 필요로 하다.
#               30이하는 청년층, 30~45는 중년층, 45~ 장년층 이렇게 구분된 내용의 새로운 
#               변수를 설정해야 한다.
#               data$age_lv[data$age <= 30] <- "청년층"

dataset01 <- read.csv(file.choose(), header=T)
dataset01
View(dataset01)
datasetcol01 <- names(dataset01)
datacol01
posData <- dataset01$position
ageData <- dataset01[,4]
ageData
choData <- c(dataset01[,c(2:5)])
choData
View(choData)
dataset01[6,]
dataset01[,3]
plot(dataset01$age)
job2 <- na.omit(dataset01$job)
job2
age2 <- na.omit(dataset01$age)
data01 <- median(dataset01$price, na.rm=T)
data02 <- mean(dataset01$price, na.rm=T)
position2 <- dataset01$position
position2[is.na(position2)] <- 0
position2
price <- dataset01$price
price[is.na(price)] <- 0
job <- dataset01$job
job[is.na(job)] <- 0
newJobVal <- price * job
newJobVal
