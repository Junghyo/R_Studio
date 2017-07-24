# data.frame
name <- c('john', 'jaehee', 'juliet', 'james')
sex <- c('f', 'f', 'f', 'm')
job <- c('althele', 'doctor', 'ceo', 'analyst')
age <- c(40, 35, 43, 29)

member <- data.frame(name, age, sex, job)
member

age[1] # 40
name[3] # juliet

member[1] # name부분이 나옴. 열단위
member[,1] # name부분이 나옴. 열단위
member[1,] # john, 40, f, althele이 나옴. 행단위

member$name # name이 나옴. 문자형vector는 data.frame 변환시 자동으로 요인(factor) 설정
member$age # age가 나옴

member
# member data.frame에서 doctor 부분을 가지고 오고 싶다면?
member[2,4] # 2행 4열의 값 : doctor
# james의 성별은?
member[4,3] # 4행 3열의 값 : m

# john의 성별을 바꾸고 싶으면? f-> m
member[1,3] <- "m" # 1행 3열의 값(f)을 m으로 변환

# 새로운 컬럼(지역)을 추가하고 싶다면? (loc를 추가)
member$loc <- c("seoul", "chicago", "paris", "london")
member
member$loc # 추가 할 경우 요인(factor)으로 설정이 안되어 있다.
member$name 

# member 정보
mode(member); class(member) # list, data.frame
str(member) # 5개의 변수, 4개의 관측치
names(member) # 변수 이름(컬럼명)
nrow(member) # 행 갯수 : 4
ncol(member) # 열 갯수 : 5


# 기술통계량, plot, data.frame 다루는데 유용한 package : Hmiscinstall.packages("Hmisc")
# psych package에도 기술통계량부분이 있으나 Hmisc가 더 유용(다만 좀 더 무겁다)
require(Hmisc)
describe(member)
describe.data.frame(member)

