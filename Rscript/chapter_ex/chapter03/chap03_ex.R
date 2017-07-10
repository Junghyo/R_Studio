# 3장 연습문제

# 1. 본문에서 작성한 info_df 변수를 다음과 같은 단계를 통해서 infoprocess.csv 파일로 저장 후
#    data.frame으로 가져오시오.
# https://www.infoplease.com/business-finance/poverty-and-income/capita-personal-income-state"
library(RCurl)
library(XML)
url = "https://www.infoplease.com/business-finance/poverty-and-income/capita-personal-income-state"
info_url <- getURL(url)
info_df <- readHTMLTable(info_url, which = 1, header=T, stringAsFactors=F)
info_df
View(info_df)
info_df <- info_df[-c(1,27),]
info_df
# 1-1 "C:\Users\acorn\Documents\R_Studio\Rscript\chapter_ex\chapter03"에 infoprocess.csv로 저장
setwd("C:/Users/acorn/Documents/R_Studio/Rscript/chapter_ex/chapter03")
write.csv(info_df, "infoprocess.csv")
# 1-2 "infoprocess.csv 파일을 infoData 변수로 가져와서 결과 확인
infoData <- read.csv(file="infoprocess.csv", header=T)
View(infoData)
# 1-3 infoData 데이트 셋 구조 보기 함수를 이용하여 관측치와 컬럼수 확인
str(infoData) # 11개 변수, 50개 관측치
library(RSADBE)
install.packages("Hmisc")
require(Hmisc)
describe(infoData)
# 1-4 1980년과 1990년을 제외한 나머지 컬럼 대상으로 상위 6개 관측치 보기
# 필요없는 컬럼 정리
View(infoData)
infoData <- infoData[,-c(1,3,4)]
