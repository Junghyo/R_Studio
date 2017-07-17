# CRAN 주소 변경
options("repos"="https://cran.ism.ac.jp/")
# 한글 자연어 분석 패키지, 한국어를 분석할수있는 총 27개의 함수포함 
install.packages("KoNLP")
install.packages("wordcloud")
library(KoNLP)
library(wordcloud)
# 한글 단어들이 있는 사전 사용(세종사전)
useSejongDic()

# 카톡 이름 및 이모티콘 사전에 추가
mergeUserDic(data.frame('카톡명','ncn'))
mergeUserDic(data.frame('(이모티콘)','ncn'))

# txt 파일을 줄마다 읽어오기
six <- file(file.choose(), encoding="UTF-8")
text <- readLines(six)
close(six)
head(text,10)

# 카카오톡 text의 형태를 분석하여 정규식으로 문자열 제거
# 2017년 x월 x일 x요일 제거
text <- gsub("\\--------------- (.*?)\\ ---------------", " ", text)

# 대괄호안의 내용 삭제(대괄호도)
text <- gsub("\\[(.*?)\\]", " ", text)

# 이모티콘 문자열 제거
text <- gsub("(이모티콘)", " ", text)

# 사진 문자열 제거
text <- gsub("사진", " ", text)

# 제거할 단어들
text <- gsub("~", " ", text)
text <- gsub("~~~", " ", text)
text <- gsub("ㅋㅋㅋ", " ", text)
text <- gsub("ㅎㅎ", " ", text)
text <- gsub("ㅋㅋㅋㅋ", " ", text)

# 한글 외에 모든 문자는 제거
text <- gsub("[^가-힣]", " ", text)
head(text,10)

# 문자 앞 뒤의 빈공간 없애주기
library(stringr)
text <- str_trim(text)

text <- Filter(function(x){nchar(x) <= 10}, text)

# KoNLP의 extractNoun을 사용하여 단어 추출
nouns = sapply(text, extractNoun, USE.NAMES=F)

# 형태소 분석 (extraNoun/ SimplePos09/ str_match)
ko.words <- function(doc){
  d <- as.character(doc)
  pos <- paste(SimplePos09(d))
  extracted <- str_match(pos, '([가-힣]+)/[NP]')
  keyword <- extracted[,2]
  keyword[!is.na(keyword)]
}
nouns <- ko.words(text)
head(nouns,30)

# 단어 길이를 제한하기 위해
unlist_nouns <- unlist(nouns)
filter2_nouns <- Filter(function(x){nchar(x) >= 2 & nchar(x) <= 4}, nouns)

# 테이블 형태로 변환
wordcount <- table(filter2_nouns)
wordcount
write.csv(wordcount, "C:/R_Studio/output/six.csv")
head(wordcount,50)
# csv로 저장해서 확인 및 worldcloud

# 색상표 가져오기
library(RColorBrewer)
palettte = brewer.pal(8,"Set2")

#텍스트마이닝 패키지에서 텍스트문서들의 집합인 코퍼스를 문서로 관리 
install.packages("tm")
library(tm)

wordcloud(names(wordcount),freq = wordcount, scale=c(5,2), rot.per=0.25, min.freq=4,
          random.order=F,colors=palettte,random.color = T)

install.packages("wordcloud2")
library(wordcloud)

wordcloud2(data=wordcount, min.freq=3)
help("wordcloud2")

